import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrimony_admin/globalVars.dart';
import 'package:matrimony_admin/models/new_user_model.dart';
import 'package:matrimony_admin/screens/profie_types/data_of_profiletypes.dart';
import 'package:matrimony_admin/screens/profie_types/profileservice.dart';
import 'package:matrimony_admin/screens/profie_types/sort_profile.dart';

class SortSearch extends StatefulWidget {
  const SortSearch({super.key});

  @override
  State<SortSearch> createState() => _SortSearchState();
}

class _SortSearchState extends State<SortSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> filteredActions = []; // Initially show all actions

  // Filter the list based on search input
  void _filterActions(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredActions = []; // Show all if query is empty
      } else {
        filteredActions = profileActions
            .where((action) => action["name"]
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _filterActions(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.blue, // Replace main_color with actual color
                        size: 25,
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      child: CupertinoSearchTextField(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        controller: _searchController,
                        onChanged: (value) {
                          _filterActions(value); // Filter as user types
                        },
                        onSubmitted: (value) {
                          _filterActions(value); // Optional: filter on submit
                        },
                        onSuffixTap: () {
                          _searchController.clear(); // Clear search on suffix tap
                          _filterActions('');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16), // Add spacing
                ListView.builder(
                  itemCount: filteredActions.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 15),
                            TextButton(
                              onPressed: () async {
                                try {
                                  List<NewUserModel> allProfiles = await ProfileService()
                                      .getsortdata(
                                          page: 1,
                                          searchtext: filteredActions[index]["name"]);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SortProfile(
                                        searchText: filteredActions[index]["name"],
                                        user_list: allProfiles,
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: $e')),
                                  );
                                }
                              },
                              child: SizedBox(
                                width: Get.width * 0.85,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    filteredActions[index]["name"],
                                    style: TextStyle(
                                      color: filteredActions[index]["name"] == "RESET"
                                          ? Colors.red
                                          : Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8), // Spacing between items
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}