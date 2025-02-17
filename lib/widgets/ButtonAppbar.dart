import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';

class ButtonAppbar extends StatelessWidget {
  const ButtonAppbar({
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
        height: isPhone(context) ?size.height * 0.05 : size.height * 0.07,
        width: isPhone(context) ?size.width * 0.12 : size.width * 0.14,
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
              width: size.width * 0.002,
            ),
            Image.asset('assets/icons/app.png', height: isPhone(context)?size.height * 0.02:size.height * 0.03, width: isPhone(context)?size.width *0.05:size.width * 0.09, fit: BoxFit.fill,),
            //Icon(Icons.menu_rounded),
          ],
        ),
      ),
    );
  }
}