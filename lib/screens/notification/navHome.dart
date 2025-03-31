import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/profile/profile_service.dart';
import 'package:matrimony_admin/screens/service/home_service.dart';
import 'package:matrimony_admin/screens/service/search_profile.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
  int index = 0;
  List<Map<dynamic, dynamic>> notificationslist = [];
  List<Map<dynamic, dynamic>> activitylist = [];
  List<Map<dynamic, dynamic>> tempnotificationslist = [];
  List<Map<dynamic, dynamic>> tempactivitylist = [];
  List<Map<dynamic, dynamic>> user1activitylist = [];
  List<Map<dynamic, dynamic>> user2activitylist = [];
  NotifyModel temp = NotifyModel();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  var type;
  DateTime? selectedDate = DateTime.now();
  List<AdminModel> alladmins = [];

  void getalladmins() async {
    AdminModel firstadmins = AdminModel(
      token: "",
      isLogOut: "",
      email: "",
      lat: 21,
      permissions: [],
      lng: 3,
      username: "All",
    );
    AdminModel secondadmins = AdminModel(
      isLogOut: "",
      email: "",
      lat: 21,
      permissions: [],
      lng: 3,
      username: "User",
      token: "",
    );

    List<AdminModel> newadmins = await CreateAdminService().getalladmins();
    alladmins = [firstadmins, secondadmins, ...newadmins];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getalladmins();
    _dbref = FirebaseDatabase.instance.ref();
    _dbref2 = FirebaseDatabase.instance.ref();
    _dbref = _dbref.child('user1');
    _dbref2 = _dbref2.child('user2');
    SearchProfile().addtoadminnotification(
      userid: "2345",
      useremail: "",
      userimage: "",
      title: "${userSave.displayName} SEEN ALL ACTIVITIES IN NOTIFICATION DATED ${DateFormat("dd-mm-yy").format(DateTime.now())}",
      email: userSave.email??"",
      subtitle: "",
    );
    setlist();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  setlist() async {
    await setdata();
  }

  int page = 1;
  int perPage = 10;
  bool isLoading = false;
  List<AdminNotificationModel> allnotifications = [];
  setdata({bool isRefresh = false}) async {
    setState(() {
      isLoading = true;
    });

    if (isRefresh) {
      page = 1;
      allnotifications.clear();
    }

    List<AdminNotificationModel> notifications = await HomeService().getAdminNotifications(page, perPage);

    notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    if (notifications.isNotEmpty) {
      setState(() {
        allnotifications.addAll(notifications);
        page++;
      });
    }

    setState(() {
      isLoading = false;
    });
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
        return;
      } else {
        for (var element in tempnotificationslist) {
          if (element['text'].toLowerCase().contains(searchText.toLowerCase())) {
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
          if (element['text'].toLowerCase().contains(searchText.toLowerCase())) {
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
      allnotifications.clear();
      setState(() {});
    }

    List<AdminNotificationModel> noti = await HomeService().getsearchNotifications(title: title, page: searchpage);
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      allnotifications.clear();
      page = 0;
      SearchProfile().addtoadminnotification(
        userid: "",
        useremail: "",
        userimage: userSave.imageUrls!.isEmpty ? "" : userSave.imageUrls![0],
        title: "${userSave.displayName} SEEN NOTIFICATION OF ${DateFormat('EEEE MMMM d y H:m').format(DateTime.parse(picked.toString()).toLocal())}",
        email: userSave.email??"",
        subtitle: "",
      );
      allnotifications = await NotiService().getdateNotifications(
        picked.year.toString(),
        picked.month.toString(),
        picked.day.toString(),
        page,
        100,
      );
      setState(() {});
    }
  }

  void _onRefresh() async {
    await setdata(isRefresh: true);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await setdata();
    _refreshController.loadComplete();
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
                        const AssetImage('images/notification.png'),
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
                        child: const Text("Notifications"),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back_ios, color: main_color),
                ),
                backgroundColor: Colors.white,
              ),
            ),
            body: Column(
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
                              hint: const Text(
                                "All",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  type = val;
                                });
                              },
                              value: type,
                              items: alladmins.map<DropdownMenuItem<AdminModel>>((AdminModel value) {
                                return DropdownMenuItem<AdminModel>(
                                  value: value,
                                  onTap: () {
                                    if (value.username == "All") {
                                      setlist();
                                    } else if (value.username == "User") {
                                      allnotifications.clear();
                                      _searchResults.clear();
                                      setState(() {});
                                      SearchProfile().addtoadminnotification(
                                        userid: widget.newUserModel!.id!,
                                        useremail: widget.newUserModel!.email!,
                                        userimage: widget.newUserModel!.imageurls!.isEmpty
                                            ? ""
                                            : widget.newUserModel!.imageurls![0],
                                        title:
                                            "${userSave.displayName} SEEN ${widget.newUserModel!.name.substring(0, 1).toUpperCase()} ${widget.newUserModel!.surname.toLowerCase()} ${widget.newUserModel!.puid} ACTIVITIES IN NOTIFICATION",
                                        email: userSave.email??"",
                                        subtitle: "",
                                      );
                                    } else {
                                      SearchProfile().addtoadminnotification(
                                        userid: "d",
                                        useremail: "elmail",
                                        userimage: "",
                                        title: "${userSave.displayName} SEEN ${value.username} ACTIVITIES IN NOTIFICATION",
                                        email: userSave.email??"",
                                        subtitle: "",
                                      );
                                      if ((value.username == "admin" &&
                                              listofadminpermissions!.contains("Can see main admin activities")) ||
                                          listofadminpermissions!.contains("All")) {
                                        getalladminnotifications(value.email);
                                      } else if ((value.username == "admin 1" &&
                                              listofadminpermissions!.contains("Can see main admin activities")) ||
                                          listofadminpermissions!.contains("All")) {
                                        getalladminnotifications(value.email);
                                      } else if (value.username == "admin" && listofadminpermissions!.contains("All")) {
                                        getalladminnotifications(value.email);
                                      }
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.person_2_outlined,
                                        color: main_color,
                                      ),
                                      Text(value.username),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: 200,
                        child: CupertinoSearchTextField(
                          controller: _searchController,
                          onChanged: (value) {
                            allnotifications.clear();
                            setState(() {});
                            searchnoti(value);
                          },
                          onSubmitted: (value) {
                            searchnoti(value);
                            SearchProfile().addtoadminnotification(
                              userid: widget.newUserModel!.id!,
                              useremail: widget.newUserModel!.email!,
                              userimage: widget.newUserModel!.imageurls!.isEmpty
                                  ? ""
                                  : widget.newUserModel!.imageurls![0],
                              title: "${userSave.displayName} SEARCH $value IN ALL ACTIVITIES",
                              email: userSave.email??"",
                              subtitle: "",
                            );
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
                        icon:  Icon(
                          Icons.calendar_month,
                          color: main_color,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    header: const WaterDropHeader(),
                    footer: const ClassicFooter(),
                    child: allnotifications.isEmpty && _searchResults.isEmpty
                        ? ListView.builder(
                            itemCount: widget.newUserModel!.activities!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: NotificationWidget3(
                                  notiData: widget.newUserModel!.activities![index],
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: _searchResults.isEmpty ? allnotifications.length : _searchResults.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index < allnotifications.length) {
                                return NotificationWidget2(
                                  notiData: allnotifications[index],
                                );
                              } else if (_searchResults.length > 1) {
                                return NotificationWidget2(
                                  notiData: _searchResults[index],
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
