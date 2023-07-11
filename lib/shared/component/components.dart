import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });

Widget defalutFormfeild({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmited,
  GestureTapCallback? onTap,
  ValueChanged<String>? onChanged,
  required FormFieldValidator<String> valdiate,
  required String label,
  required IconData prefix,
  bool ispassword = false,
  IconData? suffix,
  Function? suffixpressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: ispassword,
      onFieldSubmitted: (s) {
        onSubmited!(s);
      },
      onChanged: onChanged,
      onTap: onTap,
      validator: valdiate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixpressed!();
                },
                icon: Icon(suffix))
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
