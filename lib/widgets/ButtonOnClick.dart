import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';

class ButtonOnClick extends StatelessWidget {
  const ButtonOnClick({
    super.key,
    required this.size,
    required this.press,
    required this.buttonName
  });

  final Size size;
  final VoidCallback press;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Card(
        color: kTextDateColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          // side: BorderSide(
          //   color: Colors.grey,
          // ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: double.infinity,
          height: size.height * 0.06,
          child: Center(
              child: Text(
            buttonName,
            style: TextStyle(color: kNaviPrimaryColor, fontSize: isPhone(context) ? 16 : 26, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}