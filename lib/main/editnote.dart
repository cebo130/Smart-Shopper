import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_shopper/main/main.dart';
import 'package:flutter/material.dart';

import 'MyOrders.dart';
import 'main.dart';

class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState();
}

class _editnoteState extends State<editnote> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    title = TextEditingController(text: widget.docid.get('title'));
    content = TextEditingController(text: widget.docid.get('content'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      leading:  IconButton(
        onPressed: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyOrders())),
        icon: Icon(Icons.arrow_back_ios,color: Colors.orange,),
      ),
        title: Text(
          'Edit Item',
          style: TextStyle(color: Colors.orange),
        ),
        centerTitle: true,

      ),
      body: Container(
        child: Column(
          children: [
            SizedBox( height:30),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.orangeAccent,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'content',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orangeAccent,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: TextField(
                  controller: content,
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'content',
                  ),
                ),
              ),
            ),
            SizedBox(height:20),
            Row(
              children: [
                SizedBox(width:15),
                Container(
                  height:50,
                  width: 160,
                  //color: Colors.orange,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)
                    ),
                    color: Colors.white,
                    onPressed: () {
                      widget.docid.reference.delete().whenComplete(() {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (_) => MyOrders()));
                      });
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.orange,fontSize: 19),
                    ),
                  ),
                ),
                SizedBox(width:10),
                Container(
                  height:50,
                  width: 160,
                  //color: Colors.orange,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)
                    ),
                    color: Colors.white,
                    onPressed: () {
                      widget.docid.reference.update({
                        'title': title.text,
                        'content': content.text,
                      }).whenComplete(() {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (_) => MyOrders()));
                      });
                    },
                    child: Text(
                      "save",
                      style: TextStyle(color: Colors.orange,fontSize: 19),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height:20),
          ],
        ),
      ),
    );
  }
}