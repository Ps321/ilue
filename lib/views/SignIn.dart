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
