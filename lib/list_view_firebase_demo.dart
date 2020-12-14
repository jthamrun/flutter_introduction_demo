import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_page_demo/add_friend.dart';
import 'package:login_page_demo/friend_contact_details.dart';
import 'package:login_page_demo/current_user_profile.dart';
import 'package:login_page_demo/user_profile_page.dart';
import 'dart:math';


import 'chat_page.dart';
import 'friend_data.dart';

class ListViewFirebaseDemoPage extends StatefulWidget {
  @override
  _ListViewFirebaseDemoPageState createState() => _ListViewFirebaseDemoPageState();
}

class _ListViewFirebaseDemoPageState extends State<ListViewFirebaseDemoPage> {

  // List<Friend> friends = <Friend>[];

  var friendList = [];

  _ListViewFirebaseDemoPageState() {
    refreshFriendList();
    FirebaseDatabase.instance.reference().child("friends").onChildChanged.listen((event) {
      print("Data changed!");
      refreshFriendList();
    });
    FirebaseDatabase.instance.reference().child("friends").onChildRemoved.listen((event) {
      refreshFriendList();
    });
    FirebaseDatabase.instance.reference().child("friends").onChildAdded.listen((event) {
      refreshFriendList();
    });
  }

  void refreshFriendList() {
    // load all friends from Firebase Database and display them in the ListView
    FirebaseDatabase.instance.reference().child("friends").once()
        .then((datasnapshot) {
      print("Successfully loaded data!");
      print(datasnapshot);
      print("Key: ");
      print(datasnapshot.key);
      print("Value: ");
      print(datasnapshot.value);
      print("Iterating the value map");
      var friendTmpList = [];
      datasnapshot.value.forEach((k, v) {
        print(k);
        print(v);
        if (v['image'] == null) {
          v['image'] = 'https://www.kindpng.com/picc/m/495-4952535_create-digital-profile-icon-blue-user-profile-icon.png';
        }
        friendTmpList.add(v);
      });
      print("Final Friend List: ");
      print(friendTmpList);
      friendList = friendTmpList;
      setState(() {
        FirebaseAuth.instance.currentUser().then((value) {
          print(value);
          var uid = value.uid;
          print("uid: " + uid);
          var userInfo = datasnapshot.value[uid];
          CurrentUserProfile.currentUser = userInfo;
          print("Current user info: " + userInfo.toString());
        }).catchError((error) {
          print("Failed to get the user info");
          print(error);
        });
      });
    }).catchError((error) {
      print("Failed to load data!");
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends List'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              print("clicked");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfilePage()),
              );
            },
          )
        ]
      ),
      body: ListView.builder(
        itemCount: friendList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              print("The item is clicked " + index.toString());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatPage(friendList[index]['uid'])),
              );
            },
            title: Container(
              height: 50,
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('${friendList[index]['image']}'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${friendList[index]['name']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Text(
                        '${friendList[index]['phone']}'
                      )
                    ],
                  ),
                  Spacer(),
                  Text(
                    '${friendList[index]['type']}'
                  )
                ],
              )
            ),
          );
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //refreshFriendList();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatPage('group')),
          );
        },
        child: Icon(Icons.message),
      ),
      );
  }
}