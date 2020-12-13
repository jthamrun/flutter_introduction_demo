import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_page_demo/add_friend.dart';
import 'package:login_page_demo/friend_contact_details.dart';
import 'dart:math';


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
        v['image'] = 'https://www.kindpng.com/picc/m/495-4952535_create-digital-profile-icon-blue-user-profile-icon.png';
        friendTmpList.add(v);
      });
      print("Final Friend List: ");
      print(friendTmpList);
      friendList = friendTmpList;
      setState(() {

      });
    }).catchError((error) {
      print("Failed to load data!");
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: friendList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              print("The item is clicked " + index.toString());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FriendContactDetailsPage(friendList[index])),
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
          refreshFriendList();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => AddFriendPage()),
          // );
        },
        child: Icon(Icons.refresh),
      ),
      );
  }
}