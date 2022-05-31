import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../imports.dart';
import '../../modules/auth/data/user.dart';

class Business extends StatefulWidget {
  Business({Key? key}) : super(key: key);

  @override
  State<Business> createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  static final usersCol =
  FirebaseFirestore.instance.collection('users').withConverter<User>(
    fromFirestore: (e, _) => User.fromMap(e.data()!),
    toFirestore: (m, _) => m.toMap(),
  );
  static DocumentReference<User> userDoc([String? id]) =>
      usersCol.doc(id);
  User user = authProvider.user!;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(130,212,246, 1),
        elevation: 0.0,
        title: Text("Register as a Business"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Image.asset('assets/images/business.png'),
                SizedBox(height: 5,),
                Text("If you are a Brand, Hospital, Doctor, Playhouse or any Business/Service related to the Mothers? Kindly click on this.",
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600
                ),),
                SizedBox(height: 10),
                ElevatedButton(onPressed: (){
                  if(user.isBrand ==  true){
                    final snackBar = SnackBar(content: Text('You are already approved as a business'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }else{
                  if(user.wantsBrand == false){
                    userDoc(user.id).update({
                      'wantsBrand' : true
                    });
                    user.wantsBrand = true;
                    final snackBar = SnackBar(content: Text('Request received. We will process it soon :)'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }else if(user.wantsBrand == true){
                    final snackBar = SnackBar(content: Text('You have already requested once'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
                  },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(200, 226, 141, 170)),
                  overlayColor: MaterialStateProperty.all(Colors.blue)
                ), child: Text("Yes, I am a business"),)


              ],
            ),
          ),
        ),
      ),
    );
  }
}
