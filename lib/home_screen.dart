import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String userEmail = "";

  Future getUserEmail()async{
    SharedPreferences userCred = await SharedPreferences.getInstance();
    return userCred.getString("email");
  }

  void userLogout()async{
    await FirebaseAuth.instance.signOut();
    SharedPreferences userCred = await SharedPreferences.getInstance();
    userCred.clear();
    Timer(Duration(milliseconds: 2000), () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyHome(),)));
  }

  @override
  void initState() {
    getUserEmail().then((value) => setState(() {
      userEmail = value;
    }));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: GestureDetector(
          onDoubleTap: (){
            userLogout();
          },
          child: Text(userEmail)),),
    );
  }
}
