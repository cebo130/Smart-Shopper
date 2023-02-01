import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({ required this.uid });
  final CollectionReference brewC = FirebaseFirestore.instance.collection('Aorders');
  Future updateUseData(String title, String content) async {
    return await brewC.doc(uid).set({
      'title': title,
      'content': content,
    });
  }
}