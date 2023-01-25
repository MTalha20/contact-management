import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DateTime now = DateTime.now();
final firebaseauth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;

class firebaseMethods {
  void signOut(path) async {
    await FirebaseAuth.instance.signOut().then((value) {
      path;
    });
  }

  void userdata(userName, phoneNumber) {
    try {
      db.collection("users").doc(firebaseauth.currentUser!.uid).set({
        "userName": userName,
        "phoneNumber": phoneNumber,
        "user_id": firebaseauth.currentUser!.uid,
      });
      print('DB Created');
    } catch (e) {
      print(e.toString());
    }
  }

  void getUserData() {
    db
        .collection("users")
        .where('user_id', isEqualTo: firebaseauth.currentUser!.uid)
        .get();
  }
}

class contactCard {

  var newList = [];

  addContacts(userName, phoneNumber, email) async {
    await db.collection("Contacts").add({
      "name": userName,
      "number": phoneNumber,
      "email": email,
      "user_id": firebaseauth.currentUser!.uid,
      "timestamp": FieldValue.serverTimestamp(),
    });
    
  }

  editContacts(userName, phoneNumber,email ,id, datetime) async {
    try {
      await FirebaseFirestore.instance.collection("Contacts").doc(id).update({
      "name": userName,
      "number": phoneNumber,
      "email": email,
      "user_id": firebaseauth.currentUser!.uid,
      "timestamp": datetime,
    });
    print("Edited");
    } catch (e) {
      print(e.toString());  
    }
  }

  void deleteContacts(id) async {
    await db.collection("Contacts").doc(id).delete();
    print("deleted");
  }

 void lastdoc() async {
    try {
      var doc = await db
          .collection("Contacts")
          .where(
            'user_id',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid,
          )
          .orderBy('timestamp', descending: true)
          .get();
          print("---------- Last Doc ------------");
          print(doc);
        
    } catch (e) {
      print("new list error");
    }
  }

}
