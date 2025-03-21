import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:matrimony_admin/Chat/widgets/message_video_player.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../../globalVars.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
  }) : super(key: key);
  final String message;               
  final String date;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
          minWidth: 30,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: main_color,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ),
                child:identifyTextType(message) == "Website URL"
                    ? AnyLinkPreview(
                        link: message,
                        displayDirection: UIDirection.uiDirectionVertical,
                        showMultimedia: true,
                        bodyMaxLines: 5,
                        removeElevation: true,
                        backgroundColor: main_color,
                        bodyTextOverflow: TextOverflow.ellipsis,
                        titleStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        bodyStyle: TextStyle(color: Colors.black, fontSize: 12),
                      )
                    : identifyTextType(message) == "Image URL"
                        ? Image.network(
                            message,
                            height: 300,
                          )
                        : identifyTextType(message) == "Video URL"
                            ? MessageVideoPlayer(videoUrl: message)
                            : identifyTextType(message) == "Audio URL"
                                ? VoiceMessageView(
                                  backgroundColor: main_color,
                                  activeSliderColor: Colors.white, 
                                  circlesColor: Colors.black,
                                  playPauseButtonLoadingColor: const Color.fromRGBO(0, 0, 0, 1),

                                  controller: VoiceController(
                                    isFile: false,
                                    
                                    maxDuration: Duration(minutes: 5),
                                    audioSrc:
                                        message,
                                    onComplete: () {
                                      /// do something on complete
                                    },
                                    onPause: () {
                                      /// do something on pause
                                    },
                                    onPlaying: () {
                                      /// do something on playing
                                    },
                                    onError: (err) {
                                      /// do somethin on error
                                    },
                                  ),
                                 
                                  innerPadding: 12,
                                  cornerRadius: 20,
                                )
                                : Text(
                  message,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontFamily: 'Sans-serif'),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 10,
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 8,
                    fontFamily: 'Sans-serif',
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
