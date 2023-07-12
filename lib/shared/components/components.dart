import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultTextFormField(
{
  @ required TextEditingController? controller,
  double radius =15,
  IconData? preicon,
  IconData? suficon,
  String? label,
  VoidCallback? sufixOnPressed,
  Function(String?)? onChanged,
  Function(String?)? onSubmited,
 String? Function(String?)? validate,
  bool isSecure=false,
  TextInputType? type
}
    )
{
return TextFormField(
  obscureText: isSecure,
  controller:controller ,
  keyboardType: type,
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
    ),
    prefixIcon: Icon(preicon),
    suffixIcon: IconButton(
      onPressed: sufixOnPressed,
        icon: Icon(suficon)),
    labelText: label,
  ),
  onChanged: onChanged,
  onFieldSubmitted: onSubmited,
  validator: validate,
);
}

Widget defaultTextButton({
  String? text,
  VoidCallback? function,
  Color? TextColor,
})
{
  return TextButton(
      onPressed:function ,
      child: Text(
        '$text',
          style: TextStyle(
            color: TextColor
          ),
      ),
  );
}