import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Catageoriers/Edit.dart';
import 'package:flutter_application_1/notes/Addnotes.dart';
import 'package:flutter_application_1/notes/Editnotes.dart';
import 'package:get/get.dart';

class View_Notes extends StatefulWidget {
  final String catagoryid;
  const View_Notes({super.key, required this.catagoryid});

  @override
  State<View_Notes> createState() => _View_NotesState();
}

class _View_NotesState extends State<View_Notes> {
  bool isloading = true;
  List<QueryDocumentSnapshot> data = [];

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("catagories")
        .doc(widget.catagoryid)
        .collection("note")
        .get();

    await Future.delayed(Duration(milliseconds: 500));
    data.addAll(querySnapshot.docs);
    isloading = false;
    setState(() {});
  }

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddNotes(
                    docid: widget.catagoryid,
                  )));
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text(" notes ".toUpperCase()),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "login",
                  (route) => false,
                );
              },
              icon: Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: isloading == true
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 150,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onLongPress: () {
                      showDialog<String>(
                        barrierColor: Colors.orange.shade100.withOpacity(0.6),
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          shadowColor: Colors.green,
                          backgroundColor: Colors.orange,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              width: double.minPositive,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Card.filled(
                                    color: Colors.green[200],
                                    child: const Text(
                                      '  اختر ماذا تريد ؟؟  ',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Card.filled(
                                          color: Colors.green[200],
                                          child: TextButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection("catagories")
                                                  .doc(widget.catagoryid)
                                                  .collection("note")
                                                  .doc(data[index].id)
                                                  .delete();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          View_Notes(
                                                              catagoryid: widget
                                                                  .catagoryid)));
                                            },
                                            child: const Text(
                                              'Delete',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Card.filled(
                                          color: Colors.green[200],
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    Edit_Notes(
                                                  notedocid: data[index].id,
                                                  oldnotes: data[index]["note"],
                                                  categorydocid:
                                                      widget.catagoryid,
                                                ),
                                              ));
                                            },
                                            child: const Text(
                                              'Edit',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ])
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: SingleChildScrollView(
                      child: Card(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                "${data[index]["note"]}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
