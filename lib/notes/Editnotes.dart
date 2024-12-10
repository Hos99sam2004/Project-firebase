import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Componants/MaterialButtons.dart';
import 'package:flutter_application_1/Componants/TextFormField.dart';
import 'package:flutter_application_1/notes/Viewnotes.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class Edit_Notes extends StatefulWidget {
  final String notedocid;
  final String oldnotes;
  final String categorydocid;

  const Edit_Notes(
      {super.key,
      required this.notedocid,
      required this.oldnotes,
      required this.categorydocid});

  @override
  State<Edit_Notes> createState() => _Edit_NotesState();
}

class _Edit_NotesState extends State<Edit_Notes> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  TextEditingController Note = TextEditingController();

  ///

  bool isloading = false;
  EditNotes() async {
    CollectionReference collectionnote = FirebaseFirestore.instance
        .collection('catagories')
        .doc(widget.categorydocid)
        .collection("note");
    if (_formKey.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
        await collectionnote
            .doc(widget.notedocid)
            .set({'note': Note.text}, SetOptions(merge: true));
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => View_Notes(
                    catagoryid: widget.categorydocid,
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
  void initState() {
    super.initState();
    Note.text = widget.oldnotes;
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
          title: Text("Edit Notes"),
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
                        hinttext: "notes",
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Name is Empty";
                          }
                        },
                        title: "Edit the note",
                      ),
                      SizedBox(
                        width: 120,
                        child: CustomMaterialButtons(
                            hsized: 30,
                            text: "Save",
                            Bcolor: Colors.amber,
                            onTap: () {
                              EditNotes();
                            },
                            image_path: ""),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
