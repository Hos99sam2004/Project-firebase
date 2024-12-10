import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextform extends StatelessWidget {
  final String hinttext;
  final String title;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
  const CustomTextform({
    super.key,
    required this.mycontroller,
    required this.hinttext,
    required this.validator,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, backgroundColor: Colors.amber[100]),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          validator: validator,
          controller: mycontroller,
          decoration: InputDecoration(
              hintText: hinttext,
              hintStyle: const TextStyle(color: Colors.blueGrey, fontSize: 15),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20),
              // suffixIcon: const Icon(CupertinoIcons.eye_fill),
              // prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                  gapPadding: 4.0, borderRadius: BorderRadius.circular(50))),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
