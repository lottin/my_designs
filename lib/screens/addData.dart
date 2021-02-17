import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddData extends StatelessWidget {
  String firstName;
  String lastName;
  String age;
  String title;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'firstName': firstName,
        'lastName':lastName ,
        'age': age
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Text app'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              TextField(
                onChanged: (val){
                  title = val;
                },
                decoration: InputDecoration(
                  hintText: "title",
                ),
              ),
              TextField(
                onChanged: (val){
                  firstName = val;
                },
                decoration: InputDecoration(
                  hintText: "Firstname",
                ),
              ),
              TextField(
                onChanged: (val){
                  lastName = val;
                },
                decoration: InputDecoration(
                  hintText: "last Name",
                ),
              ),
              TextField(
                onChanged: (val){
                  age = val;
                },
                decoration: InputDecoration(
                  hintText: "Age",
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addUser();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

