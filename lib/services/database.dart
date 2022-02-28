import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  getUserbyUsername(name) async{


    return await FirebaseFirestore.instance.collection("users")
   .where("name",isEqualTo: name)
    .get();


  }
  getUserbyUseremail(email) async{


    return await FirebaseFirestore.instance.collection("users")
        .where("email",isEqualTo: email)
        .get();


  }
  uploadUserValues(userMap){
    FirebaseFirestore.instance.collection("users")
    .add(userMap);
}

createChatRoom(String chatroomId,chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatroomId).set(chatRoomMap).catchError((e){
       print(e.toString()) ;
    });
}
}