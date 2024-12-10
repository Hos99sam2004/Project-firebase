import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Componants/MaterialButtons.dart';
import 'package:flutter_application_1/Componants/TextFormField.dart';
import 'package:flutter_application_1/notes/Viewnotes.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class AddNotes extends StatefulWidget {
  final String docid;
  const AddNotes({super.key, required this.docid});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  TextEditingController Note = TextEditingController();

  ///
  ///
  ///

  bool isloading = false;
  addNotes() async {
    CollectionReference Collectionnote = FirebaseFirestore.instance
        .collection('catagories')
        .doc(widget.docid)
        .collection("note");
    if (_formKey.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
        DocumentReference response = await Collectionnote.add({
          'note': Note.text,
        });
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => View_Notes(
                    catagoryid: widget.docid,
                  )),
        );
      } catch (e) {
        isloading = false;
        setState(() {});
        print(e);
      }
    }
  }

  @override
  void dispose() {
    Note.dispose();
    super.dispose();
  }

  ///
  ///
  ///
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Notes"),
        ),
        body: Form(
          key: _formKey,
          child: isloading == true
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      CustomTextform(
                          mycontroller: Note,
                          hinttext: " Notes",
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Name is Empty";
                            }
                          },
                          title: "Enter your Note"),
                      SizedBox(
                        width: 120,
                        child: CustomMaterialButtons(
                            hsized: 30,
                            text: "Add",
                            Bcolor: Colors.amber,
                            onTap: () {
                              addNotes();
                            },
                            image_path: ""),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
