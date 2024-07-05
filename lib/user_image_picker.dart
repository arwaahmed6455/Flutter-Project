import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';



class UserAddImageFirebase extends StatefulWidget {
  const UserAddImageFirebase({super.key});

  @override
  State<UserAddImageFirebase> createState() => _UserAddImageFirebaseState();
}

class _UserAddImageFirebaseState extends State<UserAddImageFirebase> {

  Uint8List? webImage;

  TextEditingController userName = TextEditingController();


  void addUserWithImage()async{

    String userID = Uuid().v1();

    UploadTask uploadTask = FirebaseStorage.instance.ref().child("userImage").child(userID).putData(webImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    addUser(userID: userID, userImage: imageUrl);
    Navigator.pop(context);
  }

  void addUser({String? userID, String? userImage})async{

    await FirebaseFirestore.instance.collection("userImage").doc(userID).set({
      "id" : userID,
      "name" : userName.text,
      "imageUrl" : userImage,
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            GestureDetector(
              onTap: ()async{

                XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery);

                if(pickImage != null){
                  var convertedFile = await pickImage.readAsBytes();
                  setState(() {
                    webImage = convertedFile;
                  });
                }

                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Image Selected")));
                }



              },
              child: webImage != null ? CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 60,
                backgroundImage: webImage != null ? MemoryImage(webImage!) : null,
              ) : CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 60,
                backgroundImage: NetworkImage("data:image/png;base64,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"),
              ),
            ),
            
            SizedBox(
              height: 20,
            ),
            
            SizedBox(
                width: 200,
                child: TextFormField(
                  controller: userName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  )
                )),

            SizedBox(
              height: 20,
            ),
            
            ElevatedButton(onPressed: ()async{
              addUserWithImage();

            }, child: Text("Add Data"))


          ],
          
        ),
      ),
    );
  }
}
