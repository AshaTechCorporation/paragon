import 'package:flutter/material.dart';
import 'package:paragon/constants.dart';

class AppTextForm extends StatefulWidget {
  AppTextForm({
    Key? key,
    this.decoration,
    this.keyboardType,
    this.controller,
    this.hintText,
    this.validator,
    this.isPassword = false,
    this.enabled = true,
    this.maxline,
    this.obscureText,
    this.readOnly,
  }) : super(key: key);
  InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final bool isPassword;
  final bool enabled;
  bool? readOnly;

  final dynamic obscureText;
  int? maxline;

  @override
  State<AppTextForm> createState() => _AppTextFormState();
}

class _AppTextFormState extends State<AppTextForm> {
  late bool _show = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        // side: BorderSide(
        //   color: Colors.grey,
        // ),
        borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
      ),
      child: TextFormField(
        style: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 18 : 25),
        obscureText: widget.isPassword ? _show : false,
        controller: widget.controller,
        readOnly: widget.readOnly ?? false,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxline ?? 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          fillColor: kNaviPrimaryColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: kTextSecondaryColor, fontSize: isPhone(context) ? 18 : 25),
          errorStyle: TextStyle(color: kStatusEndColor, fontSize: isPhone(context) ? 18 : 25),
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _show = !_show;
                    });
                  },
                  child: _show ? Image.asset('assets/icons/eye.png',scale: isPhone(context) ? 1 : 0.5,) : Image.asset('assets/icons/eyeIcon.png',scale:isPhone(context) ? 20 : 12,),
                )
              : null,
        ),
        validator: widget.validator,
      ),
    );
  }
}
