import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';



import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';


class Drawer_name extends StatefulWidget {
  _ProfileUserCurrent createState()=> _ProfileUserCurrent();
}
class _ProfileUserCurrent extends State<Drawer_name>{

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<AppUserProfile>>(context);

    return ListView.builder(
        itemCount:users.length,
        itemBuilder: (context, index) {
          return lessProfileCurrrentUser(users[index]);
        }
    );

    // TODO: implement build

  }
}


class lessProfileCurrrentUser extends StatefulWidget {
  final  AppUserProfile appUserData;

  lessProfileCurrrentUser(this.appUserData);

  _lessProfileCurrrentUser createState()=>_lessProfileCurrrentUser(appUserData);
}
class _lessProfileCurrrentUser extends State<lessProfileCurrrentUser>{
  final  AppUserProfile appUserData;
  _lessProfileCurrrentUser(this.appUserData);



  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AppUser?>(context);
    if (currentUser == null) throw Exception("current user not found");

    var text1;

    var text=Center(child: Container(
     color: Colors.black87,
     child: Text(appUserData.name.toString(),style: TextStyle(color: Colors.white,fontSize:15,)),
   ),);

    text1=text;

    return text1;


  }
}


