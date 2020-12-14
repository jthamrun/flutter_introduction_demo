import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_page_demo/current_user_profile.dart';
import 'take_picture_page.dart';
import 'package:camera/camera.dart';

class ChatPage extends StatefulWidget {

  var uid;

  ChatPage(this.uid) {
    print("debug");
    print(this.uid);
  }

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  var firebaseMessageRoot;
  var messageController = TextEditingController();
  var scrollController = ScrollController();
  var messageList = [];


  @override
  void initState() {
    if (widget.uid == 'group') {
      firebaseMessageRoot = 'group';
    } else {
      if (CurrentUserProfile.currentUser['uid'].compareTo(widget.uid.toString()) >= 0) {
        firebaseMessageRoot = CurrentUserProfile.currentUser['uid'] + '-' + widget.uid.toString();
      } else {
        firebaseMessageRoot = widget.uid.toString() + '-' + CurrentUserProfile.currentUser['uid'];
      }
    }

    _refreshMessageList();
    FirebaseDatabase.instance.reference().child("messages/" + firebaseMessageRoot).onChildAdded.listen((event) {
      _refreshMessageList();
    });
  }

  _ChatPageState() {

  }

  void _refreshMessageList() {
    FirebaseDatabase.instance.reference().child("messages/" + firebaseMessageRoot).once()
      .then((datasnapshot) {
        print(datasnapshot.value);
        var tmpList = [];
        print("Loaded all the messages");
        datasnapshot.value.forEach((k, v) {
          v['image'] = 'https://www.kindpng.com/picc/m/495-4952535_create-digital-profile-icon-blue-user-profile-icon.png';
          tmpList.add(v);
        });
        tmpList.sort((a,b) => a['timestamp'].compareTo(b['timestamp']));
        messageList = tmpList;
        setState(() {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      }).catchError((error) {
        print("Failed to load all the messages");
        print(error);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: messageList.length,
              itemBuilder: (BuildContext context, int index) {
                return messageList[index]['uid'] == CurrentUserProfile.currentUser['uid'] ?
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              // width: 250,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 3),
                              decoration: new BoxDecoration(
                                color: Colors.grey,
                                borderRadius: new BorderRadius.all(Radius.circular(5.0))
                              ),
                              child: messageList[index]['type'] != null &&  messageList[index]['type'] == "image" ?
                              Image.network(messageList[index]['text']) :
                              Text(
                                  messageList[index]['text']
                              ),
                            ),
                            Text(
                              'Sent at ' + DateTime.fromMillisecondsSinceEpoch(messageList[index]['timestamp']).toString(),
                              style: TextStyle(
                                fontSize: 12
                              )
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${messageList[index]['image']}'
                            ),
                          ),
                        ),
                      ],
                    )
                  ) :
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${messageList[index]['image']}'
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // width: 250,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 3),
                              decoration: new BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: new BorderRadius.all(Radius.circular(5.0))
                              ),
                              child: Text(
                                  messageList[index]['text']
                              ),
                            ),
                            Text(
                                'Sent at ' + DateTime.fromMillisecondsSinceEpoch(messageList[index]['timestamp']).toString(),
                                style: TextStyle(
                                    fontSize: 12
                                )
                            )
                          ],
                        ),
                      ],
                    )
                  );
              }),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Type your message here',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.photo),
                onPressed: () async {
                  final cameras = await availableCameras();
                  final firstCamera = cameras.first;
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera)),
                  );

                  var timestamp = DateTime.now().millisecondsSinceEpoch;
                  var messageRecord = {
                    "text": result,
                    "type": "image",
                    "timestamp": timestamp,
                    "uid": CurrentUserProfile.currentUser['uid'],
                  };
                  FirebaseDatabase.instance.reference().child("messages/" + firebaseMessageRoot + "/" + timestamp.toString())
                    .set(messageRecord)
                    .then((value) {
                        print("Successfully added the message!");
                      messageController.text = "";
                    }).catchError((error) {
                      print("Failed to add the message!");
                      print(error);
                    }
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  var timestamp = DateTime.now().millisecondsSinceEpoch;
                  var messageRecord = {
                    "text": messageController.text,
                    "type": "text",
                    "timestamp": timestamp,
                    "uid": CurrentUserProfile.currentUser['uid'],
                  };
                  FirebaseDatabase.instance.reference().child("messages/" + firebaseMessageRoot + "/" + timestamp.toString())
                    .set(messageRecord)
                    .then((value) {
                      print("Successfully added the message!");
                      messageController.text = "";
                    }).catchError((error) {
                      print("Failed to add the message!");
                      print(error);
                    }
                  );
                },
              )
            ],
          )
        ],
      )
    );
  }
}
