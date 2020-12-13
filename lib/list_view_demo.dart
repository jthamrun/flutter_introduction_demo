import 'package:flutter/material.dart';
import 'package:login_page_demo/add_friend.dart';
import 'package:login_page_demo/friend_contact_details.dart';
import 'dart:math';


import 'friend_data.dart';

class ListViewDemoPage extends StatefulWidget {
  @override
  _ListViewDemoPageState createState() => _ListViewDemoPageState();
}

class _ListViewDemoPageState extends State<ListViewDemoPage> {

  final List<String> entries = <String>[
    'Alice', 'Ben', 'Thomas', 'Zach', 'John', 'Tom', 'Cindy', 'Frank', 'Hugo', 'James'];
  final List<String> phones = <String>[
    '909-000-0000', '909-000-0001', '909-000-0002', '909-000-0003', '909-000-0004', '909-000-0005', '909-000-0006', '909-000-0007', '909-000-0008', '909-000-0009'];

  List<Friend> friends = <Friend>[];

  _ListViewDemoPageState() {
    Friend f1 = Friend("Alice", "909-000-0000", "https://www.clipartmax.com/png/middle/162-1623921_stewardess-510x510-user-profile-icon-png.png", "HOME");
    Friend f2 = Friend("Ben", "909-000-0001", "https://www.shareicon.net/data/512x512/2016/09/15/829444_man_512x512.png", "WORK");
    Friend f3 = Friend("Zach", "909-000-0002", "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png", "CELL");
    Friend f4 = Friend("John", "909-000-0003", "https://i.dlpng.com/static/png/6342390_preview.png", "HOME");

    friends = [f1, f2, f3, f4];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              print("The item is clicked " + index.toString());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FriendContactDetailsPage(friends[index])),
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
                      backgroundImage: NetworkImage('${friends[index].imageUrl}'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${friends[index].name}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Text(
                        '${friends[index].phone}'
                      )
                    ],
                  ),
                  Spacer(),
                  Text(
                    '${friends[index].type}'
                  )
                ],
              )
            ),
          );
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFriendPage()),
          );

          // var rng = Random();
          // Friend f5 = Friend(
          //   entries[rng.nextInt(entries.length)],
          //   phones[rng.nextInt(phones.length)],
          //   "https://www.shareicon.net/data/512x512/2016/09/15/829444_man_512x512.png",
          //   "HOME"
          // );
          // friends.add(f5);
          //
          // setState(() {
          // });
        },
        child: Icon(Icons.add),
      ),
      );
  }
}
