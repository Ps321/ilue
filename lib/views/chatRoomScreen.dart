import 'package:flutter/material.dart';
import 'package:ilue/helper/authenticate.dart';
import 'package:ilue/helper/constants.dart';
import 'package:ilue/helper/helperfunction.dart';
import 'package:ilue/services/auth.dart';
import 'package:ilue/views/SignIn.dart';
import 'package:ilue/views/search.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  void initState(){
    getUserInfo();
    super.initState();
  }

  getUserInfo() async{
    Constants.myName=(await HelperFunction.getUserName())!;
  }
  AuthMethod authMethod=new AuthMethod();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.symmetric(horizontal: 0 ,vertical: 30),
            child: IconButton(
              icon: Icon(Icons.exit_to_app),
              iconSize: 40,
              color: Colors.white24,
              tooltip: 'Increase volume by 5',
              onPressed: () {
                setState(() {
                  authMethod.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context)=>Authenticate()));
                });
              },

            ),


          )),
      body: Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.symmetric(horizontal: 30 ,vertical: 30),
        child: FloatingActionButton(

          onPressed: (){

                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>SearchScreen()));
          } ,

          child: const Icon(Icons.search),
        ),
      ),
        );
  }
}
