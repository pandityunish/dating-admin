// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/common/api_routes.dart';
import 'package:matrimony_admin/globalVars.dart';

import '../../../models/new_user_model.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_webrtc/flutter_webrtc.dart' as webrtc;
class VideoCall extends StatefulWidget {
  final String profilepic;
  final NewUserModel profileDetail;
  final String currentProfilePic;

  const VideoCall({
    Key? key,
    required this.profilepic,
    required this.profileDetail, required this.currentProfilePic,
  }) : super(key: key);

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  bool isAudio = true;
  bool isSpeaker = false;
  bool isButton = false;
  bool isVideo = true;
  bool isSearch = false;
  TextEditingController _searchController = TextEditingController();

  late IO.Socket socket;
  List rooms = [];
  String? currentRoomId;
  List participants = [];
  Map<String, webrtc.RTCPeerConnection> peerConnections = {};
  Map<String, webrtc.RTCVideoRenderer> remoteRenderers = {};
  webrtc.RTCVideoRenderer localRenderer = webrtc.RTCVideoRenderer();
  webrtc.MediaStream? localStream;

  @override
  void initState() {
    super.initState();
    _initSocket();
    _initLocalMedia();
  }

  @override
  void dispose() {
    socket.dispose();
    localRenderer.dispose();
    for (var renderer in remoteRenderers.values) {
      renderer.dispose();
    }
    super.dispose();
  }

  void _initSocket() {
    socket = IO.io(
      '${baseurl}/groupVideoCall',
      IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build(),
    );

    socket.onConnect((_) {
      print('Connected to groupVideoCall namespace');
      socket.emit('register', {
        'userId': widget.profileDetail.id,
        'userName': widget.profileDetail.name ?? widget.profileDetail.id,
        'profilePic': widget.profilepic,
      });
      _listRooms();
    });

    socket.on('roomsList', (data) {
      setState(() {
        rooms = data;
      });
    });

    socket.on('roomCreated', (data) {
      setState(() {
        currentRoomId = data['roomId'];
      });
      _joinRoom(data['roomId']);
    });

    socket.on('roomJoined', (data) {
      setState(() {
        currentRoomId = data['roomId'];
        participants = data['participants'];
      });
      _startCall();
    });

    socket.on('userJoined', (data) {
      setState(() {
        participants.add(data);
      });
    });

    socket.on('userLeft', (data) {
      setState(() {
        participants.removeWhere((p) => p['id'] == data['userId']);
      });
      final userId = data['userId'];
      peerConnections[userId]?.close();
      peerConnections.remove(userId);
      remoteRenderers[userId]?.dispose();
      remoteRenderers.remove(userId);
    });

    socket.on('receiveOffer', (data) async {
      await _handleOffer(data);
    });

    socket.on('receiveAnswer', (data) async {
      await _handleAnswer(data);
    });

    socket.on('receiveIceCandidate', (data) async {
      await _handleIceCandidate(data);
    });

    socket.connect();
  }

  void _listRooms() {
    socket.emit('listRooms');
  }

  void _createRoom() {
    socket.emit('createRoom', {
      'roomName': '${widget.profileDetail.name ?? widget.profileDetail.id}\'s Room',
    });
  }

  void _joinRoom(String roomId) {
    socket.emit('joinRoom', {
      'roomId': roomId,
    });
  }

  void _switchCamera() {
    if (localStream != null) {
      final videoTracks = localStream!.getVideoTracks();
      if (videoTracks.isNotEmpty) {
        videoTracks.first.switchCamera();
      }
    }
  }

  void _toggleAudio() {
    if (localStream != null) {
      final audioTracks = localStream!.getAudioTracks();
      if (audioTracks.isNotEmpty) {
        final enabled = !isAudio;
        audioTracks.first.enabled = enabled;
        setState(() {
          isAudio = enabled;
        });
      }
    }
  }

  void _toggleVideo() {
    if (localStream != null) {
      final videoTracks = localStream!.getVideoTracks();
      if (videoTracks.isNotEmpty) {
        final enabled = !isVideo;
        videoTracks.first.enabled = enabled;
        setState(() {
          isVideo = enabled;
        });
      }
    }
  }

  void _addUser(String userId) {
    if (userId.isEmpty || currentRoomId == null) return;

    socket.emit('inviteUser', {
      'roomId': currentRoomId,
      'targetUserId': userId,
    });

    _searchController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Invitation sent to $userId'))
    );
  }
  
  void _endCall() {
    // Close all connections and leave room
    if (currentRoomId != null) {
      socket.emit('leaveRoom');
      
      // Clean up resources
      for (var pc in peerConnections.values) {
        pc.close();
      }
      peerConnections.clear();
      
      for (var renderer in remoteRenderers.values) {
        renderer.dispose();
      }
      remoteRenderers.clear();
      
      setState(() {
        currentRoomId = null;
        participants = [];
      });
    } else {
      // If not in a call, just go back
      Navigator.pop(context);
    }
  }

  Future<void> _initLocalMedia() async {
    await localRenderer.initialize();
    final stream = await webrtc.navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': true,
    });
    setState(() {
      localStream = stream;
      localRenderer.srcObject = stream;
    });
  }

  Future<void> _startCall() async {
    for (var participant in participants) {
      if (participant['id'] == widget.profileDetail.id) continue;
      await _createPeerConnection(participant['id'], isCaller: true);
    }
  }

  Future<void> _createPeerConnection(String targetUserId, {bool isCaller = false}) async {
    final pc = await webrtc.createPeerConnection({
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ]
    });

    pc.onIceCandidate = (candidate) {
      socket.emit('sendIceCandidate', {
        'targetUserId': targetUserId,
        'iceCandidate': {
          'candidate': candidate.candidate,
          'sdpMid': candidate.sdpMid,
          'sdpMLineIndex': candidate.sdpMLineIndex,
        }
      });
    };

    final renderer = webrtc.RTCVideoRenderer();
    await renderer.initialize();
    pc.onTrack = (event) {
      if (event.track.kind == 'video') {
        setState(() {
          renderer.srcObject = event.streams[0];
          remoteRenderers[targetUserId] = renderer;
        });
      }
    };

    if (localStream != null) {
      localStream!.getTracks().forEach((track) {
        pc.addTrack(track, localStream!);
      });
    }

    peerConnections[targetUserId] = pc;

    if (isCaller) {
      final offer = await pc.createOffer();
      await pc.setLocalDescription(offer);
      socket.emit('sendOffer', {
        'targetUserId': targetUserId,
        'sdpOffer': offer.toMap(),
      });
    }
  }

  Future<void> _handleOffer(data) async {
    final senderId = data['senderId'];
    final sdpOffer = data['sdpOffer'];
    await _createPeerConnection(senderId, isCaller: false);
    final pc = peerConnections[senderId]!;
    await pc.setRemoteDescription(webrtc.RTCSessionDescription(sdpOffer['sdp'], sdpOffer['type']));
    final answer = await pc.createAnswer();
    await pc.setLocalDescription(answer);
    socket.emit('sendAnswer', {
      'targetUserId': senderId,
      'sdpAnswer': answer.toMap(),
    });
  }

  Future<void> _handleAnswer(data) async {
    final senderId = data['senderId'];
    final sdpAnswer = data['sdpAnswer'];
    final pc = peerConnections[senderId];
    if (pc != null) {
      await pc.setRemoteDescription(webrtc.RTCSessionDescription(sdpAnswer['sdp'], sdpAnswer['type']));
    }
  }

  Future<void> _handleIceCandidate(data) async {
    final senderId = data['senderId'];
    final ice = data['iceCandidate'];
    final pc = peerConnections[senderId];
    if (pc != null) {
      await pc.addCandidate(webrtc.RTCIceCandidate(ice['candidate'], ice['sdpMid'], ice['sdpMLineIndex']));
    }
  }

  Widget _buildCircularButton(IconData icon, bool isActive, VoidCallback onPressed, {Color color = Colors.white}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.blue : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF38B9F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Local video preview
          Positioned(
            top: 80,
            right: 20,
            child: Container(
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: webrtc.RTCVideoView(localRenderer, mirror: true),
              ),
            ),
          ),
          // Remote videos grid
          currentRoomId == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       SizedBox(
                                  height: Get.height * 0.2,
                                ),
                     Container(
                       width: 140,
                       height: 140,
                       decoration: BoxDecoration(
                         color: Colors.white,
                         shape: BoxShape.circle,
                         image: DecorationImage(
                           image: NetworkImage(widget.profilepic),
                           fit: BoxFit.cover,
                         ),
                       ),
                     ),
                                           
                     SizedBox(height: 5),
                                            
                     SizedBox(height: 10),
                     Text(
                       "Outgoing Video Call",
                       style: TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                         fontSize: 17,
                       ),
                     ),
                                            
                     SizedBox(height: 10)
                    ],
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.only(top: 100, bottom: 100, left: 10, right: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: participants.length <= 2 ? 1 : 2,
                    childAspectRatio: 3/4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: participants.length,
                  itemBuilder: (context, index) {
                    final participant = participants[index];
                    final userId = participant['id'];
                    // Skip self in the grid
                    if (userId == widget.profileDetail.id) return SizedBox();
                    
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Video view or placeholder
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: remoteRenderers.containsKey(userId)
                                ? webrtc.RTCVideoView(remoteRenderers[userId]!)
                                : Center(child: CircularProgressIndicator(color: Colors.white)),
                          ),
                          // Participant name
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Text(
                              participant['name'] ?? 'Unknown',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
          // Controls at bottom
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                 isButton
                ? Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isButton = !isButton;
                            isSearch = !isSearch;
                          });
                        },
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.more_vert),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                     isSearch? Column(
                      children: [
                      SizedBox(
                        width: 200,
                        child: CupertinoSearchTextField(
                          controller: _searchController,
                          backgroundColor: Colors.white,
                          onChanged: (value) {
                         
                          },
                          onSubmitted: (value) {
                          
                          },
                          onSuffixTap: () {
                          setState(() {
                           _searchController.clear();
                          });
                          },
                        ),
                      ),
                      ]): InkWell(
                        onTap: (){
                          setState(() {
                            isSearch = !isSearch;
                          });
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: main_color,
                            ),
                          ),
                        ),
                      ),
                 

                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: Center(
                          child: Icon(
                            Icons.call_end,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: Get.width * 0.75,
                        height: 55,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      isSpeaker = !isSpeaker;
                                                    });
                                                    // callController.toggleMic();
                                                  },
                                                  child: Image.asset(
                                                    "images/icons/Speaker.png",
                                                    color: isSpeaker
                                                        ? main_color
                                                        : Colors.black,
                                                  )),
                                              InkWell(
                                                  onTap: () {
                                                    // controller.toggleVideo();

                                                  },
                                                  child: Image.asset(
                                                      "images/icons/video.png")),
                                              InkWell(
                                                  onTap: () {
                                                    // log("message");

                                                    setState(() {
                                                      isButton = !isButton;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.more_vert,
                                                    size: 30,
                                                  )),
                                              InkWell(
                                                onTap: () {
                                                    // controller.flipCamera();
                                                  
                                                },
                                                child: Image.asset(
                                                    "images/icons/cameraflip.png"),
                                              ),
                                              isAudio
                                                  ? InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          isAudio = !isAudio;
                                                        });
                                                        // controller.toggleMic();
                                                      },
                                                      child: Icon(
                                                        Icons.mic_off,
                                                        size: 30,
                                                      ))
                                                  : InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          isAudio = !isAudio;
                                                        });
                                                        // controller.toggleMic();

                                                      },
                                                      child: Icon(Icons.mic,
                                                          size: 30))
                                            ],
                                          ),
                                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
