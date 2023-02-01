import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Aybo extends StatefulWidget {
  const Aybo({Key? key}) : super(key: key);

  @override
  State<Aybo> createState() => _AyboState();
}

class _AyboState extends State<Aybo> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(controller: controller,),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              final name = controller.text;
              createOrder(name: name);
            },
          ),
        ],
      ),

    );
  }
  Future createOrder({required String name}) async {
    //reference a document
    final docUser = FirebaseFirestore.instance.collection('Borders').doc('qWEyre-1');
    /*final json = {
      'name': name,
      'size': 'large',
      'items': 'ubisi, bread and soy',
    };*/
    final order = Order(
      id: docUser.id,
      name: name,
      size: 'large',
      items: 'ubisi, bread and soy',
    );
    final json = order.toJson();
    //create document in firebase
    await docUser.set(json);
  }
}
class Order{
  String id;
  final String name;
  final String size;
  final String items;

  Order({
    this.id = '',
  required String this.name,
  required String this.size,
  required String this.items,
  });
  Map<String, dynamic> toJson() => {
    id: id,
    'name': name,
    'size': size,
    'items': items,
  };
  static Order fromJson(Map<String, dynamic> json) => Order(
  id: json['id'],
  name: json['name'],
  size: json['size'],
  items: json['items'],
      );
}