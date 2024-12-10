import 'package:flutter/cupertino.dart';

class Logo extends StatelessWidget {
  final String logo_path;
  const Logo({super.key, required this.logo_path});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    logo_path,
                  ),
                ),
                // color: Colors.blue,
                borderRadius: BorderRadius.circular(100)),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
