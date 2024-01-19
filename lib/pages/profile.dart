import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {

  final ref = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').doc(ref!.uid).snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              Map<dynamic, dynamic> data = snapshot.data!.data() as Map<dynamic, dynamic>;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  //this is picture box niggas
                  Center(
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.deepPurpleAccent,
                              width: 2)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/profilepic.jpg"),
                            loadingBuilder: (context, child, loadingProgress){
                              if(loadingProgress == null) return child;
                              return Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, object, stack){
                              return Container(
                                  child: Icon(Icons.error_outline, color: Colors.red,));}
                        ),
                      ),
                    ),
                  ),
                  // ListTile(
                  //   title: Text(data['username']),
                 // ),
                ],
              );
            }else{
              return Center(child: Text("Something is wrong"));
            }
  },
        ),
      ),
    );
  }
}

