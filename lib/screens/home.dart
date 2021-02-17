import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_designs/screens/addData.dart';
import 'package:my_designs/screens/create_blog.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:my_designs/services/crud.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {


  CrudMethods _crudMethods = new CrudMethods();
  CollectionReference _blog = FirebaseFirestore.instance.collection('blog');

  @override
  void initSate() async{
    super.initState();

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
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _blog.snapshots(),
        builder:(BuildContext context,  AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return SafeArea(
          child: Container(),
        );}
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBlog()));
              },
              child: Icon(
                Icons.add
              ),
            ),
          ],
        ),
      ),
    );
  }
}



