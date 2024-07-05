import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mwf08c1f/add_user.dart';
import 'package:mwf08c1f/update_screen.dart';
import 'package:mwf08c1f/user_image_picker.dart';

class UserFetchImage extends StatefulWidget {
  const UserFetchImage({super.key});

  @override
  State<UserFetchImage> createState() => _UserFetchImageState();
}

class _UserFetchImageState extends State<UserFetchImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("userImage").snapshots(),
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
                String image = snapshot.data!.docs[index]["imageUrl"];


                return ListTile(
                  title: Text(name),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(image),
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserAddImageFirebase(),));
      },
        child: Icon(Icons.add),
      ),
    );
  }
}
