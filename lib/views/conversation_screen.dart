import 'package:flutter/material.dart';
import 'package:ilue/helper/constants.dart';
class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Color.fromARGB(100, 121, 21, 119),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black87,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.white,),
                ),
                SizedBox(width: 1,),
                CircleAvatar(
                  backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/5.jpg"),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(Constants.toUser,style: TextStyle( fontSize: 16,color: Colors.white ,fontWeight: FontWeight.w600),),
                      SizedBox(height: 6,),
                      Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                    ],
                  ),
                ),
                Icon(Icons.video_call,color: Colors.white,size: 36,),
                SizedBox(width: 8,),
                Icon(Icons.call,color: Colors.white,size: 28,),
                SizedBox(width: 8,),
                Icon(Icons.more_vert_outlined,color: Colors.white,size: 26,),
              ],
            ),
          ),
        ),
      ),
      body: Stack(

        children: <Widget>[
          Align(

            alignment: Alignment.bottomLeft,
            child: Container(

              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      showModalBottomSheet<void>(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(

                                decoration: BoxDecoration(

                                    color: Color.fromRGBO(0, 0, 0, 0.7),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                            height: 200,

                            child: Center(
                              child: Column(



                                children: <Widget>[

                                  Align(
                                    alignment: Alignment.topRight,
                                    child:ElevatedButton(
                                      style: ElevatedButton.styleFrom(primary: Colors.transparent),
                                      child: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 40, ),
                                      onPressed: () => Navigator.pop(context),
                                    ) ,
                                  ),
                                  const Text('Whole apps'),

                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color:  Color.fromRGBO(128, 128, 128, 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1.0)
                          ),
                        decoration: InputDecoration(


                            hintText: "Write message...",
                            contentPadding:  EdgeInsets.fromLTRB(4,0,2,2),
                            hintStyle: TextStyle(color:  Color.fromRGBO(255, 255, 255, 0.7),letterSpacing: 1,),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){},
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Colors.purpleAccent,
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
}
