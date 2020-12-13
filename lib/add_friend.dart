import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddFriendPage extends StatefulWidget {
  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: phoneController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone',
              ),
            ),
            TextField(
              controller: typeController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Type',
              ),
            ),
            RaisedButton(
              child: Text("Add Friend"),
              onPressed: () {
                print(nameController.text);
                print(phoneController.text);
                print(typeController.text);

                var timestamp = new DateTime.now().millisecondsSinceEpoch;

                FirebaseDatabase.instance.reference().child("friends/stu" + timestamp.toString()).set(
                  {
                    "name": nameController.text,
                    "phone": phoneController.text,
                    "type": typeController.text,
                    "image": "https://www.clipartmax.com/png/middle/162-1623921_stewardess-510x510-user-profile-icon-png.png"
                  }
                ).then((value) {
                  print("Successfully added friend!");
                }).catchError((error) {
                  print("Failed to add. " + error.toString());
                });
              },
            )
          ],
        )
      )
    );
  }
}
