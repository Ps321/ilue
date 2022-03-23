import 'package:flutter/material.dart';
import 'package:ilue/helper/constants.dart';
import 'package:ilue/helper/helperfunction.dart';
import 'package:ilue/services/auth.dart';
import 'package:ilue/services/database.dart';
import 'package:ilue/views/chatRoomScreen.dart';

import 'package:ilue/widgets/widgets.dart';
class SignUp extends StatefulWidget {
  final Function toggle;
  const SignUp(this.toggle);

  //const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading=false;
  AuthMethod authMethods=new AuthMethod();
  DatabaseMethods d=new DatabaseMethods();
  HelperFunction helper=new HelperFunction();

  final formKey=GlobalKey<FormState>();
  TextEditingController usernamec=new TextEditingController();
  TextEditingController emailc=new TextEditingController();
  TextEditingController passwordc=new TextEditingController();
  signMeUp(){
    if(formKey.currentState!.validate()){
        setState(() {
          isLoading=true;
        });
        authMethods.signUpWithEmailAndPassword(emailc.text, passwordc.text).then((val) {

          Map<String,String> userMap= {
            "name":usernamec.text,
            "email":emailc.text
          };
          HelperFunction.saveUserEmail(emailc.text);
          HelperFunction.saveUserName(usernamec.text);
          d.uploadUserValues(userMap);


          HelperFunction.saveUserLoggedIn(true);
          Constants.myName=usernamec.text;
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context)=>ChatRoom()));
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
      body: isLoading? Container(
        child: Center(child: CircularProgressIndicator()),
      ):SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-50,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "HELLO!",
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
                        validator: (val){
                          return val!.isEmpty || val.length < 6?"Username should be mininum 6 or more character":null;
                        },
                      controller: usernamec,
                      style: inputfieldtext(),
                      decoration: textfieldinputdecoration("Username"),
                    ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purpleAccent)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                            ),
                            labelText: 'User Name',
                            labelStyle: TextStyle(
                              color: Colors.white
                            ),
                            hintText: 'Enter Your Name ',
                            hintStyle: TextStyle(
                              color: Colors.white
                            )
                          ),
                        ),
                      )
                      ,
                      TextFormField(
                        validator: (val){
                          return RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(val!)? null:"Please Enter valid Email";
                        },
                        controller: emailc,
                        style: inputfieldtext(),
                        decoration: textfieldinputdecoration("Email"),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val){
                          return val!.isEmpty || val.length < 6?"Password should be mininum 6 or more character":null;
                        },
                        controller: passwordc,
                        style: inputfieldtext(),
                        decoration: textfieldinputdecoration("Password"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    signMeUp();
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
                      "Sign Up",
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
                      "Already a User?",
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
                          "Sign In",
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
      ),
    );
  }
}


/*

bottomNavigationBar: new Theme(
    data: Theme.of(context).copyWith(
    // sets the background color of the `BottomNavigationBar`
    canvasColor: Colors.black,
    // sets the active color of the `BottomNavigationBar` if `Brightness` is light
    primaryColor: Colors.red,
    textTheme: Theme
        .of(context)
        .textTheme
        .copyWith(caption: new TextStyle(color: Colors.yellow))), // sets the inactive color of the `BottomNavigationBar`
    child: new BottomNavigationBar(
/*


 */
      showSelectedLabels: false,
      type: BottomNavigationBarType.shifting,
          selectedFontSize: 20,
      selectedItemColor: Colors.redAccent,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBa rItem(
              icon: Icon(Icons.message),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notification_important_outlined),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex1, //New
          onTap: onItemTapped, //New
        )
//New

        ));


*/
