import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilteringFireStore extends StatefulWidget {
  const FilteringFireStore({super.key});

  @override
  State<FilteringFireStore> createState() => _FilteringFireStoreState();
}

class _FilteringFireStoreState extends State<FilteringFireStore> {
  final Stream<QuerySnapshot> usersstream =
      FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          CollectionReference users =
              FirebaseFirestore.instance.collection('users');
          DocumentReference doc1 =
              FirebaseFirestore.instance.collection('users').doc("3");
          DocumentReference doc2 =
              FirebaseFirestore.instance.collection('users').doc("2");
          WriteBatch batch = FirebaseFirestore.instance.batch();
          batch.set(doc1, {
            "money": 900,
            "username": "farouk",
            "age": 25,
            "phone": "0123456789"
          });
          batch.delete(doc2);
          batch.commit();
          Navigator.of(context)
              .pushNamedAndRemoveUntil("filterfirestore", (route) => false);
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Container(
        child: StreamBuilder(
            stream: usersstream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Error");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Transaction_method(index, context, snapshot),
                      child: Card(
                        child: ListTile(
                          trailing:
                              Text("${snapshot.data!.docs[index]['money']}\$",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  )),
                          subtitle: Text("${snapshot.data!.docs[index]['age']}",
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          title:
                              Text("${snapshot.data!.docs[index]['username']}",
                                  style: TextStyle(
                                    // color: Colors.red,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  )),
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}

///  Transaction_method(index, context);
void Transaction_method(int index, BuildContext context, dynamic snapshot) {
  DocumentReference documentReference = FirebaseFirestore.instance
      .collection("users")
      .doc(snapshot.data!.docs[index].id);
  FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot snapshot = await transaction.get(documentReference);
    if (snapshot.exists) {
      var snapshotData = snapshot.data();
      if (snapshotData is Map<String, dynamic>) {
        int money = snapshotData['money'] + 100;
        transaction.update(documentReference, {'money': money});
      }
    }
  }).then((value) {
    const snackBar = SnackBar(
      content: Text('Successfully Updated'),
      backgroundColor: Colors.green,
      duration: Duration(milliseconds: 200),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context)
        .pushNamedAndRemoveUntil("filterfirestore", (route) => false);
  });
}
