import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_pro/Vendor/my_diary/drop_down.dart';
import 'package:final_pro/Vendor/store/create_store_screen.dart';
import 'package:get/get.dart';

import '../../widgets/flutter_custom_carousel_slider.dart';
import '../fitness_app_theme.dart';
import '../ui_view/title_view.dart';
import 'meals_list_view.dart';

class VendorMainScreen extends StatefulWidget {
  const VendorMainScreen({Key? key, this.animationController})
      : super(key: key);

  final AnimationController? animationController;
  @override
  _VendorMainScreenState createState() => _VendorMainScreenState();
}

class _VendorMainScreenState extends State<VendorMainScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 9;

    listViews.add(
      TitleView(
        titleTxt: 'Mediterranean diet',
        subTxt: 'Details',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 0, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      const CorauselCustom(),
    );
    listViews.add(
      TitleView(
        titleTxt: 'Meals today',
        subTxt: 'Customize',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 2, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      MealsListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: const Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        getMainListViewUI(),
        getAppBarUI(),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        )
      ],
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: FitnessAppTheme.grey
                            .withOpacity(0.4 * topBarOpacity),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 1,
                          top: 16 - 8.0 * topBarOpacity,
                          bottom: 12 - 8.0 * topBarOpacity,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: FutureBuilder<Map<String, dynamic>>(
                                future: getUserData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else {
                                    String userName =
                                        snapshot.data!['v_first_name'] ??
                                            'Unknown';
                                    String profilePicture = snapshot
                                            .data!['v_imageLink'] ??
                                        'https://wallpapers.com/images/featured-full/cool-profile-picture-87h46gcobjl5e4xu.jpg';
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8,
                                          right: 2,
                                          top: 10,
                                          bottom: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(profilePicture),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            userName,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily:
                                                  FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w700,
                                              fontSize:
                                                  10 + 3 - 3 * topBarOpacity,
                                              letterSpacing: 1.2,
                                              color: FitnessAppTheme.darkerText,
                                            ),
                                          ),
                                          Spacer(),
                                          SettingIconDropdown(),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Future<Map<String, dynamic>> getUserData() async {
    try {
      // Get the current user from FirebaseAuth
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Use the current user's ID to fetch user data
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('user_profile')
            .where('v_user_id', isEqualTo: currentUser.uid)
            .limit(1)
            .get();

        // Check if any documents match the query
        if (querySnapshot.docs.isNotEmpty) {
          // Get data from the first matching document
          Map<String, dynamic>? userData =
              querySnapshot.docs.first.data() as Map<String, dynamic>?;

          if (userData != null) {
            // Print the user ID and any other data you need
            print("User ID outer: ${currentUser.uid}");
            print("User Data: $userData");

            return userData;
          } else {
            print("Error: User data is null");
            return {};
          }
        } else {
          // No matching documents found
          print("User document not found for userId: ${currentUser.uid}");
          return {};
        }
      } else {
        // No current user found
        print("No current user found");
        return {};
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return {};
    }
  }
}
