import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';

class DateSelected extends StatelessWidget {
  DateSelected({
    super.key,
    required this.dateController,
    required this.press,
  });

  final TextEditingController dateController;
  VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: dateController,
        //readOnly: true,
        style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 18 : 25),
        decoration: InputDecoration(
          hintText: '',
          hintStyle: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 15 : 25),
          suffixIcon: GestureDetector(
            onTap: press,
            child: Icon(Icons.calendar_today,size: isPhone(context) ? 25 : 40,)),
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          fillColor: kNaviPrimaryColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        //onTap: press,
      ),
    );
  }
}