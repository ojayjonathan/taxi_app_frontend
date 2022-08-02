import 'package:flutter/material.dart';
import 'package:taxi_app/data/rest/client.dart';
import 'package:taxi_app/resources/palette.dart';

class UserFeedBack extends StatefulWidget {
  const UserFeedBack({Key? key}) : super(key: key);

  @override
  State<UserFeedBack> createState() => _UserFeedBackState();
}

class _UserFeedBackState extends State<UserFeedBack> {
  final TextEditingController _message = TextEditingController();
  void _sendFeedback() async {
    if (_message.text.isNotEmpty) {
      final res = await Client.customer.feedback(_message.text);
      res.when(
        (error) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "An  error occured",
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
          ),
        ),
        (data) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Thank you for the feedback",
              style: TextStyle(color: Palette.successColor),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          color: Palette.dark[2],
          child: const Text("Feedback"),
        ),
        backgroundColor: const Color(0xfffafafa),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop()),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: _sendFeedback,
              style: ElevatedButton.styleFrom(primary: Palette.accentColor),
              child: const Text(
                "submit",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Form(
              child: TextFormField(
                maxLines: 8,
                controller: _message,
                minLines: 6,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Color(0xfff3f3f4),
                    filled: true,
                    hintText: "write your feedback"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
