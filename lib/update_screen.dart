import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key,
  required this.uEmail,
  required this.uAge,
  required this.uName,
  required this.uGender,
  required this.uPassword,
    required this.uID
  });

  final String uEmail;
  final String uName;
  final String uAge;
  final String uGender;
  final String uPassword;
  final String uID;

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();

  TextEditingController password = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    name.text = widget.uName;
    email.text = widget.uEmail;
    age.text = widget.uAge;
    gender.text = widget.uGender;
    password.text = widget.uPassword;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    name.dispose();
    age.dispose();
    gender.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Container(
            width: 350,
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your Name"
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 350,
            child: TextFormField(
              controller: age,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your Age"
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 350,
            child: TextFormField(
              controller: gender,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your Gender"
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(

            width: 350,
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter your Email Address",
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 350,
            child: TextFormField(
              controller: password,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your Password"
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),

          ElevatedButton(onPressed: ()async{
            // await FirebaseFirestore.instance.collection("userData").add(
            //   {
            //     "name" : name.text,
            //     "age" : age.text,
            //     "gender" : gender.text,
            //     "email" : email.text,
            //     "password" : password.text
            //   }
            // );

            await FirebaseFirestore.instance.collection("userData").doc(widget.uID).update(
                {
                  "name" : name.text,
                  "age" : age.text,
                  "gender" : gender.text,
                  "email" : email.text,
                  "password" : password.text
                }
            );
            name.clear();
            age.clear();
            gender.clear();
            email.clear();
            password.clear();
            Navigator.pop(context);
          }, child: Text("Update User"))
        ],
      ),
    );
  }
}
