import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taxi_app/data/models/models.dart';
import 'package:taxi_app/data/providers/auth.dart';
import 'package:taxi_app/data/rest/client.dart';
import 'package:taxi_app/presentation/screens/userAccount/profilePage.dart';
import 'package:taxi_app/presentation/widgets/paints/bezier_container.dart';
import 'package:taxi_app/resources/constants.dart';
import 'package:taxi_app/resources/palette.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  User? user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    final res = await Client.customer.customerProfile();
    res.when(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.message,
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
          ),
        );
      },
      (data) {
        setState(() {
          user = data;
        });
      },
    );
  }

  int _tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {},
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _profileImage(),
                    Container(
                      constraints: BoxConstraints(minHeight: height - 250),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Palette.lighBlueColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _tabIndex = 0;
                                    });
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                        bottom:
                                            5, // Space between underline and text
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: _tabIndex == 0
                                                ? Palette.accentColor
                                                : Colors.transparent,
                                            width: 2.0, // Underline thickness
                                          ),
                                        ),
                                      ),
                                      child: _labelText("Status")),
                                ),
                                InkWell(
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                        bottom:
                                            5, // Space between underline and text
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: _tabIndex == 1
                                                ? Palette.accentColor
                                                : Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      child: _labelText("Profile")),
                                  onTap: () {
                                    setState(
                                      () {
                                        _tabIndex = 1;
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey[500],
                          ),
                          (_tabIndex == 0)
                              ? _menu()
                              : Container(
                                  child: user == null
                                      ? const CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.black87),
                                        )
                                      : ProfilePage(
                                          user: user!,
                                        ),
                                )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            right: 0,
            child: Hero(
              tag: "page_paint",
              child: BezierContainer(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 50,
        backgroundColor: Palette.accentColor,
        items: <Widget>[
          Icon(
            Icons.person,
            size: 30,
            color: Palette.dark[2],
          ),
          Icon(Icons.home, size: 30, color: Palette.dark[2]),
          Icon(Icons.phone, size: 30, color: Palette.dark[2]),
        ],
        onTap: (index) {
          if (index == 2) {
            context.pushNamed(AppRoutes.support);
          } else if (index == 1) {
            context.pushNamed(AppRoutes.home);
          }
        },
      ),
    );
  }

  Container _profileImage() {
    return Container(
      height: 180.0,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Stack(
              fit: StackFit.loose,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      height: 100.0,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Palette.primary3Color
                          //TODO:replace name initials with profile image

                          // image: DecorationImage(
                          //   image: ExactAssetImage(
                          //       'assets/profile.png'),
                          //   fit: BoxFit.cover,
                          // ),
                          ),
                      child: user != null
                          ? Text(
                              "${user?.firstName[0]}${user?.lastName[0]}"
                                  .toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold),
                            )
                          : Container(),
                    ),
                  ],
                ),
                // Padding(
                //     padding: EdgeInsets.only(top: 50.0, right: 80.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: <Widget>[
                //         CircleAvatar(
                //           backgroundColor: Palette.accentColor,
                //           radius: 20.0,
                //           child: Icon(
                //             Icons.camera_alt,
                //             color: Colors.white,
                //           ),
                //         )
                //       ],
                //     )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _labelText(String label) {
    return Text(
      label,
      style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _menu() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _menuItem(
          "My Bookings",
          Icons.bookmark,
          onPressed: () => context.pushNamed(AppRoutes.bookHistory),
        ),
        _menuItem(
          "Help",
          Icons.call,
          onPressed: () => context.pushNamed(AppRoutes.support),
        ),
        _menuItem(
          "Feedback",
          Icons.message,
          onPressed: () => context.pushNamed(AppRoutes.feedback),
        ),
        _menuItem(
          "Logout",
          Icons.exit_to_app,
          onPressed: () => context.read<AuthProvider>().logout(),
        )
      ],
    );
  }

  Widget _menuItem(
    String label,
    IconData icon, {
    Function()? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: _labelText(label),
                )
              ],
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
