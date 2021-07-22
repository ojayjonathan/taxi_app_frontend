import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:taxi_app/constants.dart';
import 'package:taxi_app/palette.dart';
import 'package:taxi_app/serializers.dart';
import 'package:taxi_app/utils/validators.dart';
import 'package:taxi_app/widgets/buttons.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({Key key, this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState(user);
}

class _ProfilePageState extends State<ProfilePage> {
  User user;
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  _ProfilePageState(this.user);
  GlobalKey<FormState> profileForm = GlobalKey<FormState>();

  void _sumitForm() async {
    if (profileForm.currentState.validate()) {
      setState(() {
        _status = true;
        FocusScope.of(context).requestFocus(FocusNode());
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Updating please wait...",
        style: TextStyle(color: Palette.successColor),
      )));
      try {
        // await UserAuthentication().registerUser(jsonEncode({
        //   "email": _email.text,
        //   "password": _password.text,
        //   "first_name": _firstName.text,
        //   "last_name": _lastName.text,
        //   "phone_number": "+254${_phoneNumber.text}",
        // }));
        //if registration was successful

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Profile was sucessfull",
          style: TextStyle(color: Palette.successColor),
        )));
        // push the user to login page
        Navigator.of(context).pushNamed(AppRoutes.login);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          e.response.toString(),
          style: TextStyle(color: Theme.of(context).errorColor),
        )));
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return SizedBox();
    }
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
                  Expanded(child: _labelText("First Name")),
                  Expanded(child: _labelText("Last Name")),
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
                        initialValue: user.firstName,
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
                        initialValue: user.lastName,
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
                      children: <Widget>[_labelText('Email ')],
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
                        initialValue: user.email,
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
                      children: <Widget>[_labelText("Mobile")],
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
                        initialValue: user.phoneNumber,
                        validator: phoneValidator,
                      ),
                    ),
                  ],
                )),
            !_status ? _getActionButtons() : Container(),
          ],
        ),
      ),
    );
  }

  Widget _labelText(String label) {
    return Text(
      label,
      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
    );
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
              child: actionButton(context, "Save", _sumitForm),
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
