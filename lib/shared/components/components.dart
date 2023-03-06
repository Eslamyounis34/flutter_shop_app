import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

// to remove onBoarding for next time
void navigteAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget defaultButton({
  double? width,
  required String btnText,
  required VoidCallback function,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Colors.blue,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          '${btnText}',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultTextField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  Function? Function(String? value)? onChange,
  required String? validate(String? value),
  bool isPassword = false,
  VoidCallback? onFormTap,
  IconData? sufficIcon,
  VoidCallback? suffixPressed,
}) =>
    TextFormField(
        controller: controller,
        keyboardType: type,
        validator: validate,
        obscureText: isPassword,
        onChanged: onChange,
        onTap: onFormTap,
        decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
            prefixIcon: Icon(prefix),
            suffixIcon: IconButton(
              icon: Icon(sufficIcon),
              onPressed: suffixPressed,
            )));

void showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: toastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color toastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.orange;
      break;
  }
  return color;
}

Widget myDivider() => Container(
      height: 2.00,
      color: Colors.grey[200],
    );
