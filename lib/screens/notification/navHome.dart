import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/profile/profile_service.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';
import '../../Chat/info.dart';
import '../../globalVars.dart';
import '../../models/admin_model.dart';
import '../../models/admin_notification_model.dart';
import '../../sendUtils/notiModel.dart';
import '../profie_types/create_admin_service.dart';
import 'Widget_Notification/notification_widget.dart';

class NavHome extends StatefulWidget {
  final NewUserModel? newUserModel;
  const NavHome({Key? key, this.newUserModel}) : super(key: key);

  @override
  State<NavHome> createState() => _NavHomeState();
}

class _NavHomeState extends State<NavHome> with TickerProviderStateMixin {
  DocumentSnapshot? lastDocument;
  late DatabaseReference _dbref;
  late DatabaseReference _dbref2;
  // late TabController _tabController;
  int index = 0;
  // DateTime time2 = DateTime.now();
  List<Map<dynamic, dynamic>> notificationslist = [];
  List<Map<dynamic, dynamic>> activitylist = [];
  List<Map<dynamic, dynamic>> tempnotificationslist = [];
  List<Map<dynamic, dynamic>> tempactivitylist = [];
  List<Map<dynamic, dynamic>> user1activitylist = [];
  List<Map<dynamic, dynamic>> user2activitylist = [];
  NotifyModel temp = NotifyModel();
  final scrollcontroller = ScrollController();
  var type;
  DateTime? selectedDate = DateTime.now();
  List<AdminModel> alladmins = [];
  void getalladmins() async {
    AdminModel firstadmins = AdminModel(
      token: "",
      isLogOut: "",
        email: "", lat: 21, permissions: [], lng: 3, username: "All");
    AdminModel secondadmins = AdminModel(
      isLogOut: "",
        email: "", lat: 21, permissions: [], lng: 3, username: "User",token: "");

    List<AdminModel> newadmins = await CreateAdminService().getalladmins();
    alladmins = [firstadmins, secondadmins, ...newadmins];
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getalladmins();
    // paginatedData();
    // _tabController = TabController(length: 2, vsync: this);
    _dbref = FirebaseDatabase.instance.ref();
    _dbref2 = FirebaseDatabase.instance.ref();
    _dbref = _dbref.child('user1');
    _dbref2 = _dbref2.child('user2');
                       SearchProfile().addtoadminnotification(userid: "2345", useremail:"", userimage: "", 
  title: "${userSave.displayName} SEEN ALL ACTIVITIES IN NOTIFICATION DATED ${DateFormat("dd-mm-yy").format(DateTime.now())}", email: userSave.email!, subtitle: "");
    setlist();
    scrollcontroller.addListener(() {
      if (scrollcontroller.position.maxScrollExtent ==
          scrollcontroller.position.pixels) {
        print("helsjkfal;dksjf");
        setlist();
      }
    });
  }

  @override
  void dispose() {
    // _tabController.dispose();
    scrollcontroller.dispose();
    super.dispose();
  }

  setlist() async {
    await setdata();
  }

  int page = 1;
  int perPage = 10;
  bool isLoading = false;
  List<AdminNotificationModel> allnotifications = [];
  setdata() async {
    // setState(() {
    //     isLoading = true;
    //   });
    // print(true);
    print("pro notif");
    // List<AdminNotificationModel> notifications =
    //     await NotiService().getdateNotifications(
    //     selectedDate!.year.toString(),
    //     selectedDate!.month.toString(),
    //     selectedDate!.day.toString(),
    //     page,
    //     30);

    List<AdminNotificationModel> notifications =
        await HomeService().getAdminNotifications(page, perPage);

    notifications.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );
    if (notifications.isNotEmpty) {
      allnotifications.addAll(notifications);

      setState(() {
        page++;
      });
    }
  }

 

  late List<AdminNotificationModel> _searchResults = [];

  TextEditingController _searchController = TextEditingController();

  void _search(String searchText) {
    if (index == 0) {
      _searchResults.clear();
      if (searchText.isEmpty) {
        for (var element in tempnotificationslist) {
          notificationslist.add(element);
        }

        // setState(() {});
        return;
      } else {
        for (var element in tempnotificationslist) {
          if (element['text']
              .toLowerCase()
              .contains(searchText.toLowerCase())) {
            notificationslist.add(element);
          }
        }
      }
    } else {
      activitylist.clear();
      if (searchText.isEmpty) {
        for (var element in tempactivitylist) {
          activitylist.add(element);
        }
        return;
      } else {
        for (var element in tempactivitylist) {
          if (element['text']
              .toLowerCase()
              .contains(searchText.toLowerCase())) {
            activitylist.add(element);
          }
        }
      }
    }

    setState(() {});
  }

  void getalladminnotifications(String email) async {
    allnotifications.clear();
    allnotifications = await HomeService().getalladminnotification(email);
    setState(() {});
  }

  int searchpage = 1;
  void searchnoti(String title) async {
    if (searchpage <= 1) {
      print(searchpage);
      allnotifications.clear();
      setState(() {});
    }

    List<AdminNotificationModel> noti = await HomeService()
        .getsearchNotifications(title: title, page: searchpage);
    Set<AdminNotificationModel> uniqueValues = Set.from(noti);

    for (AdminNotificationModel value in noti) {
      uniqueValues.add(value);
    }
    List<AdminNotificationModel> result = uniqueValues.toList();
    allnotifications.addAll(result);

    setState(() {
      searchpage++;
    });
  }

  bool isMoreData = true;
  List<Map<String, dynamic>> notification_list = [];
  void paginatedData() async {
    if (isMoreData) {
      final collectionReference =
          FirebaseFirestore.instance.collection("notifications");
      late QuerySnapshot<Map<String, dynamic>> querySnapshot;
      if (lastDocument == null) {
        querySnapshot = await collectionReference.limit(15).get();
      } else {
        querySnapshot = await collectionReference
            .limit(15)
            .startAfterDocument(lastDocument!)
            .get();
      }

      lastDocument = querySnapshot.docs.last;
      notification_list.addAll(querySnapshot.docs.map((e) => e.data()));
      setState(() {});
      if (querySnapshot.docs.length < 15) {
        isMoreData = false;
      } else {
        print("No More Data");
      }
    }
  }

  int value = 0;
  String dropdownvalue = 'ALL';
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   paginatedData();
  // }

  List<String> items = []; // list to store the fetched data from firebase
  List<String> filteredItems = []; // list to store the filtered data
  // method to filter the items based on user input
  void filterSearchResults(String query) {
    List<MessageText> tempList = notificationslist
        .map((map) => MessageText(
              text: (map['text'] != null) ? map['text'] : "",
              uid: (map['uid'] != null) ? map['uid'] : "",
              type: (map['type'] != null) ? map['type'] : "",
              imgname: (map['imgname'] != null) ? map['imgname'] : "",
              time: (map['time'] != null) ? map['time'] : "",
            ))
        .toList();
    if (query.isNotEmpty) {
      items.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          tempList.add(item as MessageText);
        }
      });
      setState(() {
        filteredItems.clear();
        filteredItems.addAll(tempList as Iterable<String>);
      });
      return;
    } else {
      setState(() {
        filteredItems.clear();
        filteredItems.addAll(items);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    print(picked);
    allnotifications.clear();
    page = 0;
    SearchProfile().addtoadminnotification(
        userid: "",
        useremail: "",
        userimage: userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0],
        title:
            "${userSave.displayName} SEEN NOTIFICATION OF ${DateFormat('EEEE MMMM d y H:m').format(DateTime.parse(picked.toString()).toLocal())}",
        email: userSave.email!,
        subtitle: "");
    allnotifications = await NotiService().getdateNotifications(
        picked!.year.toString(),
        picked.month.toString(),
        picked.day.toString(),
        page,
        100);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: CupertinoPageScaffold(
          child: DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: PreferredSize(
                     preferredSize: const Size.fromHeight(100),
                    child: AppBar(
                      elevation: 0,
                        flexibleSpace: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ImageIcon(
                                    AssetImage('images/notification.png'),
                                    size: 30,
                                    color: main_color,
                                  ),
                    
                                  DefaultTextStyle(
                                    style: TextStyle(
                                      color: main_color,
                                      fontFamily: 'Sans-serif',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                    child: Text("Notifications"),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                
                                 
                                  // actions: [CupertinoSearchTextField(
                                  //   controller: _searchController,
                                  //   onChanged: _search,
                                  // ),],
                                ],
                              ),
                            ),
                 
                      leading: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.arrow_back_ios, color: main_color)),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: DropdownButton(
                                                         isExpanded: true,              
                                      hint: Text("All",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black)),
                                      onChanged: (val) {
                                        setState(() {
                                          this.type = val;
                                        });
                                      },
                                      value: this.type,
                                      items: alladmins
                                          .map<DropdownMenuItem<AdminModel>>(
                                              (AdminModel value) {
                                        return DropdownMenuItem<AdminModel>(
                                            value: value,
                                            onTap: () {
                                              print("Hello");
                                              if (value.username == "All") {
                                                setlist();
                                              } else if (value.username ==
                                                  "User") {
                                                allnotifications.clear();
                                                _searchResults.clear();
                                                setState(() {});
                                                SearchProfile()
                                                    .addtoadminnotification(
                                                        userid: widget
                                                            .newUserModel!.id!,
                                                        useremail: widget
                                                            .newUserModel!.email!,
                                                        userimage: widget
                                                                .newUserModel!
                                                                .imageurls!
                                                                .isEmpty
                                                            ? ""
                                                            : widget.newUserModel!
                                                                .imageurls![0],
                                                        title:
                                                            "${userSave.displayName} SEEN ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname..toLowerCase()} ${widget.newUserModel!.puid} ACTIVITIES IN NOTIFICATION",
                                                        email: userSave.email!,
                                                        subtitle: "");
                                              } else {
                                                SearchProfile()
                                                    .addtoadminnotification(
                                                        userid: "d",
                                                        useremail: "elmail",
                                                        userimage: "",
                                                        title:
                                                            "${userSave.displayName} SEEN ${value.username} ACTIVITIES IN NOTIFICATION",
                                                        email: userSave.email!,
                                                        subtitle: "");
                                                if (value.username == "admin" &&
                                                        listofadminpermissions!
                                                            .contains(
                                                                "Can see main admin activities") ||
                                                    listofadminpermissions!
                                                        .contains("All")) {
                                                  getalladminnotifications(
                                                      value.email);
                                                } else if (value.username ==
                                                            "admin 1" &&
                                                        listofadminpermissions!
                                                            .contains(
                                                                "Can see main admin activities") ||
                                                    listofadminpermissions!
                                                        .contains("All")) {
                                                  getalladminnotifications(
                                                      value.email);
                                                } else if (value.username ==
                                                            "admin" &&
                                                       
                                                    listofadminpermissions!
                                                        .contains("All")) {
                                                  getalladminnotifications(
                                                      value.email);
                                                }
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.person_2_outlined,
                                                  color: main_color,
                                                ),
                                                Text(value.username)
                                              ],
                                            ));
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 5,),
                              SizedBox(
                                // height: 30,
                                width: 200,
                                child: CupertinoSearchTextField(
                                  controller: _searchController,
                                  onChanged: (value) {
                                   allnotifications.clear();
      setState(() {});
                                    //  _search(_searchController.text);
                                     searchnoti(value);
                                  },
                                  onSubmitted: (value) {
                                    searchnoti(value);
                                    SearchProfile()
                                                  .addtoadminnotification(
                                                      userid: widget
                                                          .newUserModel!.id!,
                                                      useremail: widget
                                                          .newUserModel!.email!,
                                                      userimage: widget
                                                              .newUserModel!
                                                              .imageurls!
                                                              .isEmpty
                                                          ? ""
                                                          : widget.newUserModel!
                                                              .imageurls![0],
                                                      title:
                                                          "${userSave.displayName} SEARCH ${value} IN ALL ACTIVITIES",
                                                      email: userSave.email!,
                                                      subtitle: "");
                                  },
                                  onSuffixTap: () {
                                    setState(() {
                                      _searchController.clear();
                                    });
                                    _search(_searchController.text);
                                  },
                                ),
                              ),
                                IconButton(
                            onPressed: () {
                              _selectDate(context);
                            },
                            icon: Icon(
                              Icons.calendar_month,
                              color: Colors.black,
                            ))
                            ],
                          ),
                        ),
                        if (allnotifications.isEmpty &&
                            _searchResults.isEmpty) ...[
                          ListView.builder(
                              itemCount:
                                  widget.newUserModel!.activities!.length,
                              shrinkWrap: true,
                              controller: scrollcontroller,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: NotificationWidget3(
                                    notiData:
                                        widget.newUserModel!.activities![index],
                                  ),
                                );
                              }),
                        ] else ...[
                          ListView.builder(
                            itemCount: _searchResults.isEmpty
                                ? allnotifications.length + 1
                                : _searchResults.length,
                            shrinkWrap: true,
                            controller: scrollcontroller,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              if (index < allnotifications.length) {
                                return NotificationWidget2(
                                  notiData: allnotifications[index],
                                );
                              } else if (_searchResults.length > 1) {
                                return NotificationWidget2(
                                  notiData: _searchResults[index],
                                );
                              } else {
                                return InkWell(
                                  onTap: () {
                                    if (_searchController.text.isNotEmpty) {
                                      searchnoti(_searchController.text);
                                    }
                                    setlist();
                                  },
                                  child: selectedDate!.day == DateTime.now().day
                                      ? Container(
                                          height: 40,
                                          width: 50,
                                          color: main_color,
                                          child: const Center(
                                            child: Text("Load more"),
                                          ),
                                        )
                                      : Center(),
                                );
                                // return  Center(child: CircularProgressIndicator());
                                // setlist();
                                // if (isLoading==false) {
                                //   return Center(child: CircularProgressIndicator());
                                // } else {
                                //   setlist(); // Trigger data loading
                                //   return SizedBox(); // Return an empty SizedBox
                                // }
                              }
                            },
                          ),
                        ],
                      ],
                    ),
                  )))),
    );
  }
}
