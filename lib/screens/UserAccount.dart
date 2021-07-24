import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/palette.dart';
import 'package:taxi_app/screens/auth/auth_services.dart';
import 'package:taxi_app/screens/profilePage.dart';
import 'package:taxi_app/serializers.dart';

class AccountPage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  void getUser() async {
    // ignore: invalid_return_type_for_catch_error
    try {
      user = await UserAuthentication.getUserProfile();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        e.response.toString(),
        style: TextStyle(color: Theme.of(context).errorColor),
      )));
    }
  }

  int _tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 180.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Stack(fit: StackFit.loose, children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image:
                                          ExactAssetImage('assets/profile.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 50.0, right: 80.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Palette.accentColor,
                                    radius: 20.0,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )),
                        ]),
                      )
                    ],
                  ),
                ),
                Container(
                    constraints: BoxConstraints(minHeight: height - 250),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
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
                                    padding: EdgeInsets.only(
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
                                    ))),
                                    child: _labelText("Status")),
                              ),
                              InkWell(
                                child: Container(
                                    padding: EdgeInsets.only(
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
                                      )),
                                    ),
                                    child: _labelText("Profile")),
                                onTap: () {
                                  setState(() {
                                    _tabIndex = 1;
                                  });
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
                            : ProfilePage(
                                user: user,
                              ),
                      ],
                    ))
              ],
            ),
          ],
        ),
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
              Navigator.of(context).pushNamed(AppRoutes.support);
            } else if (index == 1) {
              Navigator.of(context).pushNamed(AppRoutes.home);
            }
          }),
    );
  }

  Widget _labelText(String label) {
    return Text(
      label,
      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _menu() {
    //TODO: add account navigation list
    Future<void> logout() async {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.clear();
      Navigator.of(context).pushNamed(AppRoutes.splash);
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _menuItem("My Bookings", Icons.bookmark,
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.bookHistory)),
        _menuItem("Help", Icons.call,
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.support)),
        _menuItem("Feedback", Icons.message,
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.feedback)),
        _menuItem("Logout", Icons.exit_to_app, onPressed: logout)
      ],
    );
  }

  Widget _menuItem(String label, IconData icon, {Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
          IconButton(onPressed: onPressed, icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
