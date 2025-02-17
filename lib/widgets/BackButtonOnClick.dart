import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';

class BackButtonOnClick extends StatelessWidget {
  const BackButtonOnClick({
    super.key,
    required this.size,
    required this.press
  });

  final Size size;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: size.height * 0.06,
        width: size.width * 0.12,
        decoration: BoxDecoration(
          border: Border.all(color: kBordercolor, width: 2.0, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(12),
          //color: Colors.yellowAccent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.01,
              width: size.width * 0.02,
            ),
            Icon(Icons.arrow_back_ios, color: kNaviPrimaryColor, size: isPhone(context) ?25:35,),
          ],
        ),
      ),
    );
  }
}