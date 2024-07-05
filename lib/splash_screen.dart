import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mwf08c1f/home_screen.dart';
import 'package:mwf08c1f/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Future getUserCred()async{
    SharedPreferences userCred = await SharedPreferences.getInstance();
    var userEmail = userCred.getString("email");

    if(userEmail != null){
      Timer(Duration(milliseconds: 2000), () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),)));
    }
    else{
      Timer(Duration(milliseconds: 2000), () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyHome(),)));
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    getUserCred();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Splash Screen"),
          CircularProgressIndicator()
        ],
      ),),
    );
  }
}
