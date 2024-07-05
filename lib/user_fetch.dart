import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mwf08c1f/add_user.dart';
import 'package:mwf08c1f/update_screen.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("userData").snapshots(),
          builder: (context, snapshot) {



            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }

            if(snapshot.hasData){

              var dataLength = snapshot.data!.docs.length;

              return dataLength != 0 ? ListView.builder(
                itemCount: dataLength,
                itemBuilder: (context, index) {

                  String name = snapshot.data!.docs[index]["name"];
                  String email = snapshot.data!.docs[index]["email"];
                  String password = snapshot.data!.docs[index]["password"];
                  String age = snapshot.data!.docs[index]["age"];
                  String gender = snapshot.data!.docs[index]["gender"];
                  String userID = snapshot.data!.docs[index]["id"];

                  return ListTile(
                    title: Text(name),
                    subtitle: Text(email),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [


                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUser(
                              uID: userID,
                              uName: name,
                              uGender: gender,
                              uAge: age,
                              uEmail: email,
                              uPassword: password,
                            ),));
                          }, icon: Icon(Icons.update, color: Colors.green,)),


                          IconButton(onPressed: ()async{

                            await FirebaseFirestore.instance.collection("userData").doc(userID).delete();

                          }, icon: Icon(Icons.delete, color: Colors.red,)),
                        ],
                      ),
                    ),
                  );

                },) : Center(child: Text("Nothing to Show"),);

            }

            if(snapshot.hasError){
              return Center(child: Icon(Icons.error,color: Colors.red,),);
            }



            return Container();
          },),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>AddUser(),));
      },
        child: Icon(Icons.add),
      ),
    );
  }
}
