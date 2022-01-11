import 'package:flutter/material.dart';

Widget defaultButton({
  double wid = double.infinity,
  double r = 10.0,
  required String text,
  bool isUpper = true,
  Color background = Colors.blue,
  required Function() function,
}) =>
    Container(
      width: wid,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(
          r,
        ),
      ),
      child: FlatButton(
        onPressed: function,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required Function() function,
  required String text,
}) => TextButton(
    onPressed: function,
    child:  Text(text)
);


Widget defaultTextForm({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?)? validation,
  bool isPassword = false,
  required String label,
  required IconData prefix,
   IconData? suffix,
  Function()? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: validation ,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,

        suffixIcon:IconButton(
          onPressed:suffixPressed,
          icon: Icon(
            suffix,
          ),
        ),
        prefixIcon: Icon(
          prefix,
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false,
);

Widget buildSeparator() => Container(
  height: 1.0,
  width: double.infinity,
  color: Colors.grey[300],
);

