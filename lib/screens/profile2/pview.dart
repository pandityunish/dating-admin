import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../globalVars.dart';
import '../../models/user_model.dart';
import '../profile/ProfilePage.dart';

class prViewed extends StatelessWidget {
  const prViewed({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      /*theme: ThemeData(
        primarySwatch: main_color,
      ),*/
      debugShowCheckedModeBanner: false,
      color: Colors.black,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getRequestedProfileData();
    getShortlistedProfileData();
  }

  var user_requests_data;
  var user_short_data;
  List<User> userlist = [];
  getRequestedProfileData() async {
    var fireStore = FirebaseFirestore.instance;
    var abc = await fireStore
        .collection("user_data")
        .where('uid', whereIn: friendr)
        .get();
    setState(() {
      user_requests_data = abc;
      print(abc);
    });
    setState(() {
      // userlist=user_data.docs.map((e) => e.data())()
      user_requests_data.docs.forEach((element) {
        // print(element..toString());
        userlist.add(User.fromdoc(element));
      });
    });
  }

  List<User> userShortlist = [];
  getShortlistedProfileData() async {
    var fireStore = FirebaseFirestore.instance;
    var short = await fireStore
        .collection("user_data")
        .where('uid', whereIn: shortFriend)
        .get();
    setState(() {
      user_short_data = short;
    });
    setState(() {
      // userlist=user_data.docs.map((e) => e.data())()
      user_short_data.docs.forEach((element) {
        // print(element..toString());
        userShortlist.add(User.fromdoc(element));
      });
    });
  }

  container(User userData) {
    return GestureDetector(
      onTap: () {
        print("hello");
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (builder) => ProfilePage(userSave: userData)));
      },
      child: Container(
          child: Column(
        children: [
          Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: (userData.imageUrls == null ||
                          userData.imageUrls!.isEmpty)
                      ? const NetworkImage(
                          "https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=")
                      : NetworkImage(userData.imageUrls![0]),
                  fit: BoxFit.cover,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ("${userData.name} ${userData.surname}"),
                  style: TextStyle(color: Colors.white70),
                ),
                Text(
                  '📍 24 km 🟢',
                  style: TextStyle(color: Colors.white70),
                )
              ],
            ),
          ),
          Text("8/12/21"),
          SizedBox(height: 20)
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 2,
        length: 5,
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.lightBlue, //change your color here
              ),
              backgroundColor: Colors.white,
              title: const Text(
                'Profile Viewed',
                style: TextStyle(color: Colors.black),
              ),
              //centerTitle: true,
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: main_color,
                tabs: const <Widget>[
                  Tab(
                    child: Text('Shortlisted',
                        style: TextStyle(color: Colors.black)),
                  ),
                  Tab(
                    child: Text('Profile Viewed (20)',
                        style: TextStyle(color: Colors.black)),
                  ),
                  Tab(
                    child: Text('Requested',
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
                labelColor: Colors.black,
              ),
            ),
            body: TabBarView(children: [
              Center(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: shortFriend!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 1.5,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    // DocumentSnapshot snap =
                    //     (snapshot.data! as dynamic).docs[index];

                    return (userShortlist != null)
                        ? container(userShortlist[index])
                        : Center(
                            child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(main_color)),
                          );
                  },
                ),
              ),
              Center(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 1.5,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    // DocumentSnapshot snap =
                    //     (snapshot.data! as dynamic).docs[index];

                    return Container(
                        child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://picsum.photos/id/669/200/300"),
                                fit: BoxFit.cover,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shyama, 25',
                                style: TextStyle(color: Colors.white70),
                              ),
                              Text(
                                '📍 24 km 🟢',
                                style: TextStyle(color: Colors.white70),
                              )
                            ],
                          ),
                        ),
                        Text("8/12/21"),
                        SizedBox(height: 20)
                      ],
                    ));
                  },
                ),
              ),
              Center(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: friendr!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 1.5,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    //Getting Data

                    return (userlist != null)
                        ? container(userlist[index])
                        : Center(
                            child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(main_color)),
                          );
                  },
                ),
              ),
            ])));
  }
}
