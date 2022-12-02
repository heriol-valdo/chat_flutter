import 'package:flutter/material.dart';
// ici cest le fichier de configuration des TextFormField
const textInputDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white)
  ),
  fillColor: Colors.white,
  filled: true,
 // contentPadding: EdgeInsets.all(12.0),
  // en cas d'erreur les bordure devienne rouge
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.red, width:1.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.red, width:1.0),
  ),
  // initialisation par defaut quand le TextFormField viens d'etre creer
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.white, width:1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.blue, width:1.0),
  ),
);