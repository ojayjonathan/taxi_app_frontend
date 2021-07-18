import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:taxi_app/palette.dart';
import 'package:taxi_app/screens/auth/signup.dart';
import 'package:taxi_app/widgets/buttons.dart';
import 'package:taxi_app/widgets/paints/bezierContainer.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  GlobalKey<FormState> profileForm = GlobalKey<FormState>();
  void validateForm() {
    if (profileForm.currentState.validate()) {
      setState(() {
        _status = true;
        FocusScope.of(context).requestFocus(FocusNode());
      });
      print("valid");
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
                height: 250.0,
                child: Stack(children: [
                  Positioned(
                      top: -height * .15,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: Hero(tag: "page_paint", child: BezierContainer())),
                  Column(
                    children: <Widget>[
                      backButton(context),
                      Padding(
                        padding: EdgeInsets.only(top: 80.0),
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
                ]),
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
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _tabIndex = 0;
                                  });
                                },
                                child: Text(
                                  "Status",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: _tabIndex == 0
                                          ? Palette.accentColor
                                          : Palette.dark[2],
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Text(
                                  "Profile",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: _tabIndex == 1
                                          ? Palette.accentColor
                                          : Palette.dark[2],
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onTap: () {
                                  setState(() {
                                    _tabIndex = 1;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey[500],
                      ),
                      (_tabIndex == 0) ? _menu() : _personalInformation(),
                    ],
                  ))
            ],
          ),
        ],
      ),
    ));
  }

  Form _personalInformation() {
    return Form(
      key: profileForm,
      child: Padding(
        padding: EdgeInsets.only(bottom: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Personal Information',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        _status ? _getEditIcon() : Container(),
                      ],
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'First Name',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Last Name',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter First Name",
                        ),
                        enabled: !_status,
                        autofocus: !_status,
                        validator: RequiredValidator(errorText: "Required"),
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter Last Name",
                        ),
                        enabled: !_status,
                        autofocus: !_status,
                        validator: RequiredValidator(errorText: "Required"),
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Email ',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(hintText: "Enter Email"),
                        enabled: !_status,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Required"),
                          EmailValidator(
                              errorText: "Please a provide valid email")
                        ]),
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Mobile',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Enter Mobile Number",
                            prefixText: "+254"),
                        enabled: !_status,
                        validator: phoneValidator,
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text(
                          'Pin Code',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          'State',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      flex: 2,
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: TextFormField(
                          decoration:
                              const InputDecoration(hintText: "Enter Pin Code"),
                          enabled: !_status,
                        ),
                      ),
                      flex: 2,
                    ),
                    Flexible(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(hintText: "Enter State"),
                        enabled: !_status,
                      ),
                      flex: 2,
                    ),
                  ],
                )),
            !_status ? _getActionButtons() : Container(),
          ],
        ),
      ),
    );
  }

  Widget _menu() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(child: Text("item 1")),
        Text("item 1"),
        Text("item 2"),
      ],
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: actionButton(context, "Save", validateForm),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: cancelButton(
                  context,
                  "Cancel",
                  () {
                    setState(() {
                      _status = true;
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  },
                )),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Palette.accentColor,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
