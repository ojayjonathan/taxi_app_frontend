import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:taxi_app/data/auth_services.dart';
import 'package:taxi_app/data/models.dart';
import 'package:taxi_app/presentation/widgets/buttons.dart';
import 'package:taxi_app/resources/palette.dart';
import 'package:taxi_app/resources/utils/validators.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  GlobalKey<FormState> profileForm = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    user = widget.user;
    _emailController.text = user!.email;
    _firstNameController.text = user!.firstName;
    _lastNameController.text = user!.lastName;
    _phoneNumberController.text = user!.phoneNumber;
    super.initState();
  }

  void _sumitForm() async {
    //update user profile
    if (profileForm.currentState!.validate()) {
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
        User _updatedUser = await UserAuthentication.updateProfile(
          jsonEncode(
            {
              "email": _emailController.text,
              "first_name": _firstNameController.text,
              "last_name": _lastNameController.text,
              "phone_number":
                  "+254${(_phoneNumberController.text).substring(1)}",
            },
          ),
        );
        setState(() {
          user = _updatedUser;
        });
        //if profile update was successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Profile update was sucessfull",
              style: TextStyle(color: Palette.successColor),
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              // e  .response.toString(),
              // TODO: display error
              "ERROR",
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              ),
            ),
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
                      decoration: InputDecoration(hintText: "Enter First Name"),
                      enabled: !_status,
                      validator: RequiredValidator(errorText: "Required"),
                      controller: _firstNameController,
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Last Name",
                      ),
                      enabled: !_status,
                      controller: _lastNameController,
                      validator: RequiredValidator(errorText: "Required"),
                    ),
                  ),
                ],
              ),
            ),
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
              ),
            ),
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
                      controller: _emailController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Required"),
                        EmailValidator(
                            errorText: "Please a provide valid email")
                      ]),
                    ),
                  ),
                ],
              ),
            ),
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
                        hintText: "Enter Mobile Number",
                      ),
                      enabled: !_status,
                      validator: phoneValidator,
                      controller: _phoneNumberController,
                    ),
                  ),
                ],
              ),
            ),
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
                    setState(
                      () {
                        _status = true;
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    );
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
