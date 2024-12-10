import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Catageoriers/Edit.dart';
import 'package:flutter_application_1/notes/Viewnotes.dart';
import 'package:get/get.dart';
// import 'package:flutter_application_1/Auth/login.dart';

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  bool isloading = true;
  List<QueryDocumentSnapshot> data = [];

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("catagories")
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    await Future.delayed(Duration(seconds: 1));
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
          Navigator.of(context).pushNamed("AddCategory");
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text(" Homepage ".toUpperCase()),
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
                  mainAxisExtent: 220,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              View_Notes(catagoryid: data[index].id)));
                    },
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
                                                  .doc(data[index].id)
                                                  .delete();
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      "homepage");
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
                                                    EditCatagorie(
                                                  docid: data[index].id,
                                                  oldname: data[index]["name"],
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
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/download (1).jpeg",
                              height: 140,
                            ),
                            Text(
                              "${data[index]["name"]}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
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
