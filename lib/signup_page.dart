import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_page_demo/user_profile.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  int _groupValue;
  String selectedPhoneType;

  void radioValueChanged(int value) {
    print("Radio Value Changed! " + value.toString());
    _groupValue = value;
    if (_groupValue == 0) {
      selectedPhoneType = "CELL";
    } else if (_groupValue == 1) {
      selectedPhoneType = "WORK";
    } else {
      selectedPhoneType = "HOME";
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: [
              Expanded(
                flex: 25,
                child: Image(
                  image: NetworkImage('https://www.wraltechwire.com/wp-content/uploads/2017/11/NewsletterSignup-Background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 60,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'Sign Up',
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
                      margin: EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                      child: TextField(
                        controller: nameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                      child: TextField(
                        controller: phoneController,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: 0,
                          groupValue: _groupValue,
                          onChanged: radioValueChanged,
                        ),
                        Text(
                          'CELL'
                        ),
                        Radio(
                          value: 1,
                          groupValue: _groupValue,
                          onChanged: radioValueChanged,
                        ),
                        Text(
                            'HOME'
                        ),
                        Radio(
                          value: 2,
                          groupValue: _groupValue,
                          onChanged: radioValueChanged,
                        ),
                        Text(
                            'WORK'
                        ),
                      ],
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      // margin: EdgeInsets.only(top: 5),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Colors.red
                            )
                        ),
                        child: Text("Sign Up"),
                        onPressed: () {
                          // Get the Email and Password from user
                          print(emailController.text);
                          print(passwordController.text);
                          // Send it to Firebase Auth
                          Future<AuthResult> result = FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                          result.then((authResult) {
                            print("Successfully signed up!");

                            var userProfile = {
                              'uid' : authResult.user.uid,
                              'name' : nameController.text,
                              'phone' : phoneController.text,
                              'email' : emailController.text,
                              'type' : selectedPhoneType
                            };
                            
                            FirebaseDatabase.instance.reference().child("friends/" + authResult.user.uid)
                              .set(userProfile)
                              .then((value) {
                                print("Successfully created profile information!");
                              }).catchError((error) {
                                print("Failed to create the profile information");
                                print(error);
                              });

                            Navigator.pop(context);
                          });
                          result.catchError((error) {
                            print("Failed to sign up!");
                            print(error.toString());
                          });
                        },
                      ),
                    ),
                  ]
                ),
              ),
              Expanded(
                flex: 5,
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
              )
            ]
          ),
        ),
      )
    );
  }
}
