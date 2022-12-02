import 'package:flutter/material.dart';



import 'package:provider/provider.dart';


import '../Google_sign_in/SignUpWidget.dart';
import '../View_page/Home_page/Acceuil.dart';
import '../models/user.dart';






class SplashScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return SignUpWidget();
    } else {
      return Acceuil();
    }
  }
}
