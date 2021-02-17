import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_designs/services/crud.dart';


class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  File _image;
  String authorName, title, desc;
   String url;
  bool _isloading = false;

  //CrudMethods crudMethods = new CrudMethods();

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        String error = "The image is empty";
      }
    });
  }

  uploadBlog() async{

    if(_image != null){
      setState(() {
        _isloading= true;
      });
      //StorageTasksnapshot
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child("blogImage").child(_image.path);
      firebase_storage.UploadTask task = ref.putFile(_image);
      final storageTaskSnapshot = await task;
      String downloadurl = await storageTaskSnapshot.ref.getDownloadURL();
      url= downloadurl;
      //TaskSnapshot
      CollectionReference blogs = FirebaseFirestore.instance.collection('blogs');
      CrudMethods crudMethods = new CrudMethods();

         Map<String, String> blogData ={
          'imgUrl': url,
          'authorName':authorName ,
          'desc': desc
        };

         crudMethods.addData( blogData);



    }else{}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter',
              style: TextStyle(fontSize: 22),
            ),
            Text(
              'Blog',
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        actions: [
          GestureDetector(
            onTap: (){
              uploadBlog();
              },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.file_upload),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: _isloading? Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(

          ),
        ):
        Container(
          child: Column(
            children: [
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  getImage();
                },
                child: _image != null ?  Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.file(_image,
                    fit: BoxFit.cover,),
                  ),
                ):
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  height: 150,
                  width: MediaQuery.of(context).size.width ,
                  child: Icon(Icons.add_a_photo,  color: Colors.black),
                ),
              ),
              SizedBox(height: 8.0,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (val){
                        authorName = val;
                      },
                      decoration: InputDecoration(
                        hintText: "Author's Name",
                      ),
                    ),
                    TextField(
                      onChanged: (val){
                        title= val;
                      },
                      decoration: InputDecoration(
                        hintText: "Title",
                      ),
                    ),
                    TextField(
                      onChanged: (val){
                        desc = val;
                      },
                      decoration: InputDecoration(
                        hintText: "Desc",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
