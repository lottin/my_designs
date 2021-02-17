import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods{

  FirebaseFirestore firestore =FirebaseFirestore.instance;
  Future<void> addData(blogData) async{
    await firestore.collection("blogs").add(blogData).catchError((e){
      print('The error is $e');
    });
  }

  fetchData() async{
    return await firestore.collection("blogs").snapshots();
  }
}