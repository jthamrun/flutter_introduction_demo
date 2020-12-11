import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_page_demo/list_view_demo.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    color: Colors.red,
                    onPressed: () {

                    },
                  ),
                ),
                Expanded(
                  flex: 70,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Image(
                      image: NetworkImage('https://metiza.com/wp-content/uploads/2018/09/tinder-logo.jpg'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 15,
                  child: IconButton(
                    icon: Icon(Icons.chat),
                    color: Colors.red,
                    onPressed: () {

                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 65,
            child: Column(
              children: [
                Expanded(
                  flex: 70,
                  child: Image(
                    image: NetworkImage('https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg'),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      children: [
                        Text(
                          'Jimmy, 22',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Spacer(),
                        Text(
                          '8',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          )
                        ),
                        Icon(
                          Icons.photo
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 50,
                          child: Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: 42
                              ),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Text(
                                  '36',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold
                                  )
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Row(
                            children: [
                              Icon(
                                Icons.book,
                                size: 42
                              ),
                              Spacer(),
                              Text(
                                '36',
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold
                                )
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.network('https://thumbs.dreamstime.com/b/red-cross-symbol-icon-as-delete-remove-fail-failure-incorr-incorrect-answer-89999776.jpg'),
                  iconSize: 100,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.network('https://upload.wikimedia.org/wikipedia/en/thumb/3/35/Information_icon.svg/768px-Information_icon.svg.png'),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListViewDemoPage()),
                    );
                  },
                ),
                IconButton(
                  icon: Image.network('https://www.vhv.rs/dpng/d/128-1281566_favorite-icon-png-image-free-download-searchpng-heart.png'),
                  iconSize: 100,
                  onPressed: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
