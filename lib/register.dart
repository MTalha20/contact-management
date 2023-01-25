import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:todoapplication/FirebaseMethods.dart';
import 'package:todoapplication/Login/loginScreen.dart';
import 'package:todoapplication/textfield.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  bool isTap = false;
  var out = "";

  void register(email, password) async {
    try {
      await firebaseauth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print("Registered");
      firebaseMethods()
          .userdata(usernameController.text, phonenumberController.text);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => logIn()));
    });
    } catch (e) {
      print("Error");
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.pink[500],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Registering Account"),
        backgroundColor: Colors.transparent,
      
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 120, left: 8, right: 8, bottom: 8 ),
          child: Container(
            // margin: EdgeInsets.only(top: 120),
            child: Column(children: [
              SizedBox(
                height: 10,
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
                            height: 480,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white
                                  .withOpacity(isTap ? 0.1 : 0.3),
                            ),
                            child: registerBox()),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              registerButton()
            ]),
          ),
        ),
      ));

  Widget registerBox() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(
                Icons.app_registration,
                size: 50,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Register Account",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        buildTextField("Email", emailController),
        SizedBox(
          height: 10,
        ),
        buildTextField("Password", passwordController),
        SizedBox(
          height: 10,
        ),
        buildTextField("username", usernameController),
        SizedBox(
          height: 10,
        ),
        buildTextField("Phone number", phonenumberController)
      ],
    );
  }

  Widget registerButton() {
    return MaterialButton(
        height: 40,
        minWidth: 120,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white.withOpacity(isTap ? 0.1 : 0.3),
        onPressed: () {
          register(emailController.text, passwordController.text);
          // var snackBar = SnackBar(content: Text(out));
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Text(
          "SignUp",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18,)
        ));
  }
}
