import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mwf08c1f/add_user.dart';
import 'package:mwf08c1f/firebase_options.dart';
import 'package:mwf08c1f/home_screen.dart';
import 'package:mwf08c1f/splash_screen.dart';
import 'package:mwf08c1f/user_fetch.dart';
import 'package:mwf08c1f/user_fetch_image.dart';
import 'package:mwf08c1f/user_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserFetchImage(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool isHide = false;
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController register_eamil = TextEditingController();

  TextEditingController register_password = TextEditingController();

  String errorString = "Register";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [

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
                obscureText: isHide,
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
            ElevatedButton(
              onPressed: ()async{
                debugPrint(email.text);
                debugPrint(password.text);

                try{
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text);
                  SharedPreferences userCred = await SharedPreferences.getInstance();
                  userCred.setString("email", email.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successful")));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                } on FirebaseAuthException catch(ex){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ex.code.toString())));
                }


                email.clear();
                password.clear();
              },
              child: Container(

                color: Colors.blue,

                width: 150,
                padding: EdgeInsets.all(15),
                child: Center(child: Text("login",style:TextStyle(
                  color: Colors.white,

                ),)),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Center(child: Text(errorString,style: TextStyle(
                  fontWeight: FontWeight.w800
              ),)),
            ),
            Container(

              width: 350,
              child: TextFormField(
                controller: register_eamil,
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
                controller: register_password,
                obscureText: isHide,
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
            ElevatedButton(
              onPressed: ()async{
                debugPrint(register_eamil.text);
                debugPrint(register_password.text);

               try{
                 await FirebaseAuth.instance.createUserWithEmailAndPassword(
                     email: register_eamil.text,
                     password: register_password.text);
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Resgister Successful")));
               } on FirebaseAuthException catch(ex){
                 setState(() {
                   errorString = ex.code.toString();
                 });
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ex.code.toString())));
               }

                register_eamil.clear();
                register_password.clear();
              },
              child: Container(

                color: const Color.fromARGB(255, 21, 35, 46),

                width: 150,
                padding: EdgeInsets.all(15),
                child: Center(child: Text("Register",style:TextStyle(
                  color: Colors.white,

                ),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

