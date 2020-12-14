import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:login_page_demo/take_picture_page.dart';


class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  var userProfile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseAuth.instance.currentUser().then((value) {
      var uid = value.uid;
      FirebaseDatabase.instance.reference().child("friends/" + uid).once()
        .then((ds) {
          print(ds.value);
          userProfile = ds.value;
          setState(() {

          });
        }).catchError((error) {
          print("Failed to get the user information!");
          print(error);
        }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: GestureDetector(
                onTap: () async {
                  print("clicked");
                  final cameras = await availableCameras();
                  final firstCamera = cameras.first;
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera)),
                  );
                  userProfile['image'] = result;
                  setState(() {
                    FirebaseDatabase.instance.reference().child("friends/" + userProfile['uid'])
                      .set(userProfile).then((value) {
                        print("Updated the user profile");
                      }).catchError((error) {
                        print("Failed to update the user profile");
                      });
                  });
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userProfile['image'] == null ? 'https://www.kindpng.com/picc/m/495-4952535_create-digital-profile-icon-blue-user-profile-icon.png' : userProfile['image']),
                ),
              ),
            ),
            Text('Name: ${userProfile['name']}'),
            Text('Email: ${userProfile['email']}'),
            Text('Phone: ${userProfile['phone']}'),
          ],
        ),
      )
    );
  }
}
