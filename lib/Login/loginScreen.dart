import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapplication/Dashboard.dart';
import 'package:todoapplication/FirebaseMethods.dart';
import 'package:todoapplication/register.dart';
import 'package:todoapplication/textfield.dart';

class logIn extends StatefulWidget {
  const logIn({Key? key}) : super(key: key);

  @override
  State<logIn> createState() => _logInState();
}

class _logInState extends State<logIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isTap = false;
   
   late var output;
   var snackBar_logging = SnackBar(content: Text("Logging"));
   var snackBar_error = SnackBar(content: Text("Invalid Credential"));


  void login(email, password) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(snackBar_logging);
      UserCredential userCredential = await firebaseauth
          .signInWithEmailAndPassword(email: 'aaa@gmail.com', password: 'aaa123').whenComplete(() => null);
      if (userCredential != null) {
        print("logging");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => todo_dashboard()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar_error);
      print("Error");
      
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
           backgroundColor: Colors.purple[900],
           
            appBar: AppBar(
              title: Text("Contact Management", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              backgroundColor: Colors.transparent,
              // elevation: 0,
            ),
            body: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.only(top: 80, left: 8, right: 8, bottom: 8),
                child: Container(
                  // margin: EdgeInsets.only(top: 80),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTapDown: (_) {
                                setState(() {
                                  isTap = true;
                                });
                              },
                              onTapUp: (_) {
                                setState(() {
                                  isTap = false;
                                });
                              },
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: AnimatedContainer(
                                      duration: Duration(microseconds: 200),
                                      height: 350,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:Colors.white.withOpacity(0.3),
                                      ),
                                      child: loginBox()),
                                ),
                              ),
                            )),
                        SizedBox(height: 20,),
                        loginButton(),
                        SizedBox(height: 30,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Register()));
                          },
                          child: Text("Swipe left for Signup",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16)),
                        )
                      ]),
                ),
              ),
            ));

Widget loginBox() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.25),
          child: Row(
            children: [
              Icon(
                Icons.login_sharp,
                size: 50,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Login",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              )
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        buildTextField("Email", emailController),
        SizedBox(
          height: 10,
        ),
        buildTextField("Password", passwordController),
        SizedBox(
          height: 10,
        ),      ],
    );
  }

Widget loginButton (){
  return MaterialButton(
          height: 40,
          minWidth: 120,
          color:Colors.white.withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: (){
            login(
                emailController.text,
                passwordController.text,
              );},
          child: Text(
              "Login",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ));

}
}



