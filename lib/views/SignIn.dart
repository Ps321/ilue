import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ilue/helper/constants.dart';
import 'package:ilue/helper/helperfunction.dart';
import 'package:ilue/services/auth.dart';
import 'package:ilue/services/database.dart';
import 'package:ilue/views/chatRoomScreen.dart';
import 'package:ilue/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  //const SignIn({Key? key}) : super(key: key);

    final Function toggle;
    const SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey=GlobalKey<FormState>();
  AuthMethod auth=new AuthMethod();
  DatabaseMethods database=new DatabaseMethods();
  TextEditingController usernamec=new TextEditingController();
  TextEditingController emailc=new TextEditingController();
  TextEditingController passwordc=new TextEditingController();

  bool isLoading=false;

  QuerySnapshot? snapshotuser;

  signIn(){
    print("idhr aaya");
    if(formKey.currentState!.validate()){

      HelperFunction.saveUserEmail(emailc.text);
      setState(() {
        isLoading=true;
      });

      auth.signInWithEmailAndPassword(emailc.text, passwordc.text).then((value) {
        if(value !=null){
          database.getUserbyUseremail(emailc.text).then((val){
            snapshotuser=val;
             HelperFunction.saveUserName(snapshotuser!.docs[0]['name']);
          });
          HelperFunction.saveUserLoggedIn(true);
          Constants.myName=snapshotuser!.docs[0]['name'];
          print(Constants.myName);
          Navigator.pushReplacement(context,
              MaterialPageRoute(
                  builder: (context)=>ChatRoom()
              ));
        }
      });


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Align(
            alignment: Alignment.topRight,
            child: Text(
              "ilue",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          )),
      body: Container(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Welcome Back!!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 28),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailc,
                      validator: (val){
                        return RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(val!)? null:"Please Enter valid Email";
                      },
                      style: inputfieldtext(),
                      decoration: textfieldinputdecoration("Username"),
                    ),
                    TextFormField(
                      obscureText:true,
                      controller: passwordc,
                      validator: (val){
                        return val!.isEmpty || val.length < 6?"Password should be mininum 6 or more character":null;
                      },

                      style: inputfieldtext(),
                      decoration: textfieldinputdecoration("Password"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    "Forgot Password?",
                    style: inputfieldtext(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (){
                  signIn();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        const Color.fromRGBO(177, 47, 223, 1.0),
                        const Color.fromRGBO(133, 18, 174, 1.0)
                      ]),
                      borderRadius: BorderRadius.circular(60)),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New User? ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: (){
                      widget.toggle();
                    },
                    child: Container(

                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Color.fromRGBO(133, 18, 174, 1.0),
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


/*Navigation

import 'package:flutter/material.dart';
import 'package:flutter_try1/main.dart';
import 'package:flutter_try1/profile.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var _selectedIndex1 = 3;
  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.call,
      size: 150,
    ),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
    ProfileUI2(),
  ];

  void onItemTapped(int index) {
    if(index==0){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
    }
    setState(() {
      _selectedIndex1 = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: const Text('Emoji Picker Example App'),
        ),
        body: Center(
          child: _pages.elementAt(_selectedIndex1),
        ),
        bottomNavigationBar: BottomNavigationBar(
/*


 */
          type: BottomNavigationBarType.shifting,
          selectedFontSize: 20,
          selectedIconTheme: IconThemeData(color: Colors.amberAccent),
          selectedItemColor: Colors.amberAccent,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.message,color: Colors.black,),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search,color: Colors.black,),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notification_important_outlined,color: Colors.black,),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,color: Colors.black,),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex1, //New
          onTap: onItemTapped, //New
        )
//New

        );
  }
}




*/






/* Profile.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileUI2 extends StatefulWidget {
  const ProfileUI2({Key? key}) : super(key: key);


  @override
  _ProfileUI2State createState() => _ProfileUI2State();
}

class _ProfileUI2State extends State<ProfileUI2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(

              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "add you image URL here "
                          ),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    child: Container(
                      alignment: Alignment(0.0,2.5),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "Add you profile DP image URL here "
                        ),
                        radius: 60.0,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 60,
                ),
                Text(
                  "Rajat Palankar"
                  ,style: TextStyle(
                    fontSize: 25.0,
                    color:Colors.blueGrey,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400
                ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Belgaum, India"
                  ,style: TextStyle(
                    fontSize: 18.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "App Developer at XYZ Company"
                  ,style: TextStyle(
                    fontSize: 15.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                    margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),

                    elevation: 2.0,
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 30),
                        child: Text("Skill Sets",style: TextStyle(
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300
                        ),))
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "App Developer || Digital Marketer"
                  ,style: TextStyle(
                    fontSize: 18.0,
                    color:Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300
                ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text("Project",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w600
                                ),),
                              SizedBox(
                                height: 7,
                              ),
                              Text("15",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w300
                                ),)
                            ],
                          ),
                        ),
                        Expanded(
                          child:
                          Column(
                            children: [
                              Text("Followers",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w600
                                ),),
                              SizedBox(
                                height: 7,
                              ),
                              Text("2000",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w300
                                ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: (){

                      },
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.pink,Colors.redAccent]
                          ),
                          borderRadius: BorderRadius.circular(30.0),

                        ),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
                          alignment: Alignment.center,
                          child: Text(
                            "Contact me",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: (){

                      },
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.pink,Colors.redAccent]
                          ),
                          borderRadius: BorderRadius.circular(80.0),

                        ),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
                          alignment: Alignment.center,
                          child: Text(
                            "Portfolio",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}


*/






/* Emoji Keyboard

import 'dart:async';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_try1/navigation.dart';
import 'package:flutter_try1/profile.dart';

void main() {
  runApp(MyApp());
}

/// Example for EmojiPickerFlutter
class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;

  Timer? _timer;
  var focusNode = FocusNode();
  @override
  void initState() {
    focusNode.addListener(() {
      print(focusNode.hasFocus);
      if(focusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
        print("aaya");
      }

    });

    super.initState();
  }
   _onfocuschange(){
    print("aaya");
  }
  _onEmojiSelected(Emoji emoji) {
    _controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder:(context)=> Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Emoji Picker Example App'),
          ),
          body: Column(
            children: [
              Expanded(child: Container(
                child: FlatButton(
                  onPressed: (){
                    print("hua");
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context)=>Navigation(

                            )
                        ));
                  },
                  child: Text("New page"),

                ),
              )),
              Container(
                  height: 66.0,
                  color: Colors.blue,
                  child: Row(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: () {

                            if(focusNode.hasFocus){

                              focusNode.unfocus();
                            }
                            _timer = new Timer(const Duration(milliseconds: 200), () {
                              setState(() {
                                emojiShowing = !emojiShowing;
                              });
                            });
                          },
                          icon: const Icon(
                            Icons.emoji_emotions,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(

                            child: TextField(
                              focusNode: focusNode,


                                controller: _controller,
                                style: const TextStyle(
                                    fontSize: 20.0, color: Colors.black87),
                                decoration: InputDecoration(
                                  hintText: 'Type a message',
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.only(
                                      left: 16.0,
                                      bottom: 8.0,
                                      top: 8.0,
                                      right: 16.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                            onPressed: () {
                              // send message
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                            )),
                      )
                    ],
                  )),
              Offstage(
                offstage: !emojiShowing,
                child: SizedBox(
                  height: 250,
                  child: EmojiPicker(
                      onEmojiSelected: (Category category, Emoji emoji) {
                        _onEmojiSelected(emoji);
                      },
                      onBackspacePressed: _onBackspacePressed,
                      config: Config(
                          columns: 7,
                          // Issue: https://github.com/flutter/flutter/issues/28894
                          emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          initCategory: Category.RECENT,
                          bgColor: const Color(0xFFF2F2F2),
                          indicatorColor: Colors.blue,
                          iconColor: Colors.grey,
                          iconColorSelected: Colors.blue,
                          progressIndicatorColor: Colors.blue,
                          backspaceColor: Colors.blue,
                          skinToneDialogBgColor: Colors.white,
                          skinToneIndicatorColor: Colors.grey,
                          enableSkinTones: true,
                          showRecentsTab: true,
                          recentsLimit: 28,
                          noRecentsText: 'No Recents',
                          noRecentsStyle: const TextStyle(
                              fontSize: 20, color: Colors.black26),
                          tabIndicatorAnimDuration: kTabScrollDuration,
                          categoryIcons: const CategoryIcons(),
                          buttonMode: ButtonMode.MATERIAL)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*






 */


*/

