import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();

  TextEditingController password = TextEditingController();


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
          const SizedBox(
            height: 25,
          ),
          Container(
            width: 350,
            child: TextFormField(
              controller: name,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your Name"
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: 350,
            child: TextFormField(
              controller: age,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your Age"
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: 350,
            child: TextFormField(
              controller: gender,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your Gender"
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(

            width: 350,
            child: TextFormField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter your Email Address",
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: 350,
            child: TextFormField(
              controller: password,
              obscuringCharacter: "*",
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your Password"
              ),
            ),
          ),
          const SizedBox(
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
            String userID = const Uuid().v1();

            await FirebaseFirestore.instance.collection("userData").doc(userID).set(
                {
                  "id" : userID,
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
          }, child: const Text("Add User"))
        ],
      ),
    );
  }
}
