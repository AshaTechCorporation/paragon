import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';

class ContainerSetting extends StatelessWidget {
  const ContainerSetting(
      {super.key,
      required this.size,
      required this.leadingIcon,
      required this.press,
      required this.trailingIcon,
      required this.title});

  final Size size;
  final VoidCallback press;
  final String leadingIcon;
  final String trailingIcon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.90,
      height: isPhone(context) ? size.height * 0.08 : size.height * 0.07,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 1,
            spreadRadius: 1,
            color: Colors.black26,
          ),
        ],
      ),
      child: Center(
        child: GestureDetector(
          onTap: press,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 1.0),
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Image.asset(
                leadingIcon,
                fit: BoxFit.fill,
                height: size.height * 0.05,
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                  fontSize: isPhone(context) ? 18 : 28,
                  color: kTextSecondaryColor,
                  fontWeight: FontWeight.bold),
            ),
            trailing: Image.asset(
              trailingIcon,
              fit: BoxFit.fill,
              height: size.height * 0.12,
            ),
          ),
        ),
      ),
    );
  }
}
