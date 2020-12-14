import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page_demo/signup_page.dart';

import 'list_view_firebase_demo.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Messaging App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
              children: [
                Expanded(
                  flex: 30,
                  child: Image(
                    image: NetworkImage('https://www.wraltechwire.com/wp-content/uploads/2017/11/NewsletterSignup-Background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 70,
                  child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 35, right: 35, bottom: 10, top: 10),
                          child: TextField(
                            controller: emailController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 20),
                          child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Colors.red
                              )
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          height: 40,
                          width: 200,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: Colors.red
                                )
                            ),
                            child: Text("Login"),
                            onPressed: () {
                              FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: emailController.text, password: passwordController.text)
                                  .then((value) {
                                    print("Login successfully!");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ListViewFirebaseDemoPage()),
                                    );
                              }).catchError((error) {
                                print("Failed to login!");
                                print(error.toString());
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          height: 40,
                          width: 200,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: Colors.red
                                )
                            ),
                            child: Text("Sign Up"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupPage()),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Row (
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Text(
                                      'App Logo'
                                  )
                              ),
                              IconButton(
                                icon: Icon(Icons.book),
                                onPressed: () {

                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.computer),
                                onPressed: () {

                                },
                              )
                            ],
                          ),
                        ),
                      ]
                  ),
                ),
              ]
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
