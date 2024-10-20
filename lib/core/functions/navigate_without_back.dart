import 'package:flutter/material.dart';

Future<dynamic> navigateWithoutBack(BuildContext context, Widget view) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => view));
}
