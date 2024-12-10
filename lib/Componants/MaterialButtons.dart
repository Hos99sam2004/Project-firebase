import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomMaterialButtons extends StatelessWidget {
  final double hsized;
  final String text;
  Color Bcolor;
  void Function()? onTap;
  final String image_path;
  CustomMaterialButtons({
    super.key,
    required this.hsized,
    required this.text,
    required this.Bcolor,
    required this.onTap,
    required this.image_path,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: onTap,
          height: 45,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          color: Bcolor,
          textColor: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 20),
              ),
              Visibility(
                visible: image_path != "" ? true : false,
                child: Image.asset(
                  image_path,
                  width: 30,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: hsized,
        ),
      ],
    );
  }
}


//  Widget CustomMaterialButtons2(dynamic onTap, dynamic Bcolor) {
//     return Column(
//       children: [
//         MaterialButton(
//           onPressed: onTap,
//           height: 45,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//           color: Bcolor,
//           textColor: Colors.white,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 text,
//                 style: TextStyle(fontSize: 20),
//               ),
//               Visibility(
//                 visible: image_path != "" ? true : false,
//                 child: Image.asset(
//                   image_path,
//                   width: 30,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: hsized,
//         ),
//       ],
//     );
//   }
// }
