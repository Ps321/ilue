import 'package:flutter/material.dart';
import 'package:ilue/helper/authenticate.dart';
import 'package:ilue/helper/helperfunction.dart';
import 'package:ilue/views/SignUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ilue/views/chatRoomScreen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

   bool userloggedin=false;
  void initState() {
    getloginstate();
    super.initState();

  }

  getloginstate() async{
    HelperFunction.getUserLoggedIn().then((value) {
      setState(() {
        userloggedin=value!;
      });
    });
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black38,
        primarySwatch: Colors.blue,
      ),
      home:userloggedin? ChatRoom():Authenticate(),
    );
  }
}
