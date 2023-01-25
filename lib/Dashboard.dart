import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapplication/FirebaseMethods.dart';
import 'package:todoapplication/Login/loginDashboard.dart';
import 'package:todoapplication/Login/loginScreen.dart';
import 'package:todoapplication/textfield.dart';
import 'package:todoapplication/urlLauncher.dart';

class todo_dashboard extends StatefulWidget {
  const todo_dashboard({Key? key}) : super(key: key);

  @override
  State<todo_dashboard> createState() => _todo_dashboardState();
}

class _todo_dashboardState extends State<todo_dashboard> {
  var lodadedProduct = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getContacts();
    contactCard().lastdoc();
  }

  getContacts() async {
    try {
      setState(() {
        loading = true;
      });
      var response = await db
          .collection("Contacts")
          .where(
            'user_id',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
          )
          .get();
      if (response.docs.length > 0) {
        response.docs.forEach((element) {
          lodadedProduct.add({
            "name": element["name"],
            "number": element["number"],
            "email": element["email"],
            "id": element.id,
            "dateTime": element["timestamp"]
          });
        });
        print("Contact Fetched");
        print(lodadedProduct);
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  TextEditingController userController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController EmailController = TextEditingController();

  
  
  Color selectedColour(int position) {
    Color c;
    if (position % 3 == 0)
      c = Color(0xff99eedf);
    else if (position % 3 == 1)
      c = Color(0xffe52165);
    else if (position % 3 == 2)
      c = Color(0xfffcc729);
    else
      c = Color(0xff12a4d9);
    return c;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                child: FloatingActionButton(
                    backgroundColor: Colors.pink[500],
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context, builder: (context) => contactDialog("Add Contact", "Add", null));
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    )))
          ],
        ),
        appBar: AppBar(
          title: Text(
            "To-Do Application",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.purple[900],
          actions: [
            GestureDetector(
                onTap: () {
                  firebaseMethods().signOut(Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => loginDashboard()),
                      (route) => false));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Sign Out",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
              itemCount: lodadedProduct.length,
              itemBuilder: (context, int index) {
                return loading
                    ? Center(child: CircularProgressIndicator())
                    : Slidable(
                        startActionPane:
                            ActionPane(motion: StretchMotion(), children: [
                          SlidableAction(
                            onPressed: (context) {
                              contactCard()
                                  .deleteContacts(lodadedProduct[index]["id"]);
                              setState(() {
                                lodadedProduct.removeAt(index);
                              });
                            },
                            icon: Icons.delete,
                            label: "Delete",
                            backgroundColor: Colors.red,
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              userController.text = lodadedProduct[index]['name'];
                              phoneController.text = lodadedProduct[index]['number'];
                              showDialog(
                                  context: context,
                                  builder: (context) => contactDialog("Edit Contact", "Edit", index));
                            },
                            icon: Icons.edit,
                            label: "Edit",
                            backgroundColor: Colors.blue,
                          )
                        ]),
                        endActionPane:
                            ActionPane(motion: DrawerMotion(), children: [
                          SlidableAction(
                            onPressed: (context) {
                              url().sendMessage(lodadedProduct[index]["number"]);
                            },
                            icon: Icons.message,
                            label: "Message",
                            backgroundColor: Colors.pink,
                            foregroundColor: Colors.white,
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              url().makePhoneCall(lodadedProduct[index]["number"]);
                            },
                            icon: Icons.call,
                            label: "Call",
                            backgroundColor: Colors.green,
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              url().sendEmail(lodadedProduct[index]["email"]);
                            },
                            icon: Icons.email_rounded,
                            label: "Email",
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                
                        ]),
                        child: ListTile(
                          title: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: selectedColour(index),
                                child: Text(
                                  lodadedProduct[index]["name"]
                                      .toString()
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lodadedProduct[index]["name"],
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    lodadedProduct[index]["number"] ,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ));
              },
                  separatorBuilder: (context, index) => Divider()
              ),
        )
            
            );
  }

  Widget contactDialog(label, method, index) {
    return AlertDialog(
      actionsPadding: EdgeInsets.only(bottom: 12, right: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.purple[900],
      title: Text(
        label,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            children: [
              buildTextField("Username", userController),
              buildTextField("Phone Number", phoneController),
              buildTextField("Email", EmailController),
            ],
          )),
      actions: [
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.white,
          onPressed: (){
              setState(() {
                userController.clear();
                phoneController.clear();
                EmailController.clear();
                Navigator.pop(context);
              });},
              child: Text("Cancel",style: TextStyle(
                    color: Colors.purple[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 14) ),
              ),
        SizedBox(width: 20,),
        MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.white,
            onPressed: () {
              if(method == "Add"){
                  contactCard()
                  .addContacts(userController.text, phoneController.text, EmailController.text);
                  setState(() {
                  userController.clear();
                  phoneController.clear();
                  EmailController.clear();
                  lodadedProduct = [];
                });
                  getContacts();
                  Navigator.pop(context);
              }
              else{
                contactCard().editContacts(
                  userController.text,
                  phoneController.text,
                  EmailController.text,
                  lodadedProduct[index]['id'],
                  lodadedProduct[index]['dateTime']);
                  setState(() {
                  userController.clear();
                  phoneController.clear();
                  EmailController.clear();
                  lodadedProduct = [];
              });
                  getContacts();
                  Navigator.pop(context);
              }
            },
            child: Text(label,
                style: TextStyle(
                    color: Colors.purple[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 14)))
      ],
    );
  }

}