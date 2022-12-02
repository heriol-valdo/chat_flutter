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


class Drawer_picture extends StatefulWidget {
  _ProfileUserCurrent createState()=> _ProfileUserCurrent();
}
class _ProfileUserCurrent extends State<Drawer_picture>{

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



  Widget _decideImageView(){
    if(appUserData.photo.toString().isEmpty){
      return Material(
        color: Colors.transparent,
        child:  ClipOval(
          child: Ink.image(
            image: AssetImage('images/1.jpg'),
            fit: BoxFit.cover,
            width: 100,
            height: 100,
            child: InkWell(onTap:(){} ,),
          ),
        ),
      );
    } else{
      //var image = imageFile as ImagePicker;
      // return Image(image:image,width: 400,height: 200,);
      // return Image.file(File(imageFile!.path),width: 400,height: 400,);
      //  return Text("yes image selected");

      if(!kIsWeb){
        // return Image.network(imageFile!.path,width: 128,height: 128,);
        String image=appUserData.photo;
        return Image.network(image,width: 120,height: 120,);

      }else{
        String image=appUserData.photo;
        return Image.network(image,width: 120,height: 120,);
      /*  XFile? imageFile=appUserData.photo as XFile?;

        return Image.file(File(imageFile!.path),width:120,height: 120,);
      */}


    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AppUser?>(context);
    if (currentUser == null) throw Exception("current user not found");

    return ClipOval(
      child: Container(
      width: 120,
      height: 120,
      child: _decideImageView(),
    ),
    );


  }
}


