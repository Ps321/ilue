import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ilue/helper/constants.dart';
import 'package:ilue/services/database.dart';
import 'package:ilue/views/conversation_screen.dart';
import 'package:ilue/widgets/widgets.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchtext = new TextEditingController();
  DatabaseMethods d = new DatabaseMethods();
  QuerySnapshot? snap;

  initiatesearch() async {

    if(Constants.myName!=searchtext.text)
    {
      var a = await d.getUserbyUsername(searchtext.text);
      print(a.docs.length);
      setState(() {
        snap = a;
      });
    }
  }

  createchatRoom(String username){
    if(username!=Constants.myName)
    {

      String chatroomid = getChatRoomId1(username, Constants.myName);
      print("aaya");
      List<String> users = [username, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomid": chatroomid
      };
      d.createChatRoom(chatroomid, chatRoomMap);
      Constants.toUser=username;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ConversationScreen()));
    }
    else{
      print("kya re Khud ko message krega");
    }
  }



  Widget SearchTile({ String? userName,String? userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 18),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName!,style: inputfieldtext()),

            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createchatRoom(userName);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                    style: BorderStyle.solid),
                gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(177, 47, 223, 1.0),
                      const Color.fromRGBO(133, 18, 174, 1.0)
                    ]
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Text("Message",
                style: TextStyle(
                    color: Colors.white
                ),),
            ),
          )
        ],
      ),
    );
  }


  Widget searchList()
  {
    return snap !=null? ListView.builder(
      shrinkWrap: true,
        itemCount: snap!.docs.length,
        itemBuilder: (context,index){
          return SearchTile(
            userName: snap!.docs[index]["name"],
            userEmail: snap!.docs[index]["email"],
          );
        }):Container();
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.transparent,

      ),
      body: Container(

        padding: EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

              decoration: BoxDecoration(
                  color: Color(0x3E3E423C),
                  borderRadius: BorderRadius.circular(10)
              ),

              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 28),
              child: Row(
                children: [
                  Expanded(
                      child:
                      TextField(
                        autofocus: true,
                        controller: searchtext,
                        style: TextStyle(
                            color: Colors.white
                        ),
                        decoration: textfieldinputdecoration(
                            'Search Username...'),
                      )),
                  GestureDetector(
                    onTap: () {
                      initiatesearch();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              const Color.fromRGBO(177, 47, 223, 1.0),
                              const Color.fromRGBO(133, 18, 174, 1.0)
                            ]
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Image.asset("assets/images/search_white.png"),
                    ),
                  )

                ],
              ),
            ),
            searchList()
          ],
        ),
      ),

    );
  }

 @override
 void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<QuerySnapshot<Object?>>('snap', snap));
  }
}



getChatRoomId1(String a,String b){
  if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }
  else
    {
      return "$a\_$b";
    }
}


