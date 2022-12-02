import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_firebase/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


import '../../models/user.dart';
import '../../Page_connexion_authentification_screens/chat/chat_screen.dart';

import '../../models/chat_params.dart';


import '../Home_page/Acceuil.dart';
import 'ModelUser.dart';
import 'ParamsUser.dart';


class ProfileUser extends StatefulWidget{
  final ParamsUser paramsUser;
  final AppUserData user;

  const ProfileUser({Key? key, required this.paramsUser, required this.user}) : super(key: key);
  _ProfileUser createState()=> _ProfileUser(paramsUser,user);
}


class _ProfileUser extends State<ProfileUser>{

 final ParamsUser paramsUser;
 final AppUserData user;
  _ProfileUser(this.paramsUser, this.user);


 Widget _decideImageView(){
   if(paramsUser.modelUser.photo.toString().isEmpty){
     return Material(
       color: Colors.transparent,
       child: Ink.image(
         image: AssetImage('images/1.jpg'),
         fit: BoxFit.cover,
         width: 120,
         height: 120,
         child: InkWell(onTap:(){
         //  showToast("message");
           // createDialog();
        //   _showChoixDialog;
         } ,),
       ),
     );
   } else{
     //var image = imageFile as ImagePicker;
     // return Image(image:image,width: 400,height: 200,);
     // return Image.file(File(imageFile!.path),width: 400,height: 400,);
     //  return Text("yes image selected");


     if(kIsWeb){
       // return Image.network(imageFile!.path,width: 128,height: 128,);
       String image=paramsUser.modelUser.photo;
       return Image.network(image,width: 120,height: 120,);
       // return Text(appUserData.photo.toString());
     }else{
       String image=paramsUser.modelUser.photo;
       return Image.network(image,width: 120,height: 120,);
       // return Text(appUserData.photo.toString());
     //  return Image.file(File(imageFile!.path),width:128,height: 128,);
     }


   }
 }

  @override
  Widget build(BuildContext context) {
    bool etatPhone=true;
    if(paramsUser.modelUser.telephone.toString().isEmpty){etatPhone=true;}else{etatPhone=false;}
    bool etatAdress=true;
    if(paramsUser.modelUser.adresse.toString().isEmpty){etatAdress=true;}else{etatAdress=false;}
    bool etatReligion=true;
    if(paramsUser.modelUser.religion.toString().isEmpty){etatReligion=true;}else{etatReligion=false;}
    bool etatEtudes=true;
    if(paramsUser.modelUser.etudes.toString().isEmpty){etatEtudes=true;}else{etatEtudes=false;}
    bool etatTaille=true;
    if(paramsUser.modelUser.taille.toString().isEmpty){etatTaille=true;}else{etatTaille=false;}
    bool etatStatut=true;
    if(paramsUser.modelUser.statut.toString().isEmpty){etatStatut=true;}else{etatStatut=false;}
    bool etatAge=true;
    if(paramsUser.modelUser.age.toString().isEmpty){etatAge=true;}else{etatAge=false;}


    final currentUser = Provider.of<AppUser?>(context);
    if (currentUser == null) throw Exception("current user not found");

    // TODO: implement build
   return Scaffold(

     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.email,size: 20,color: Colors.white,),
       backgroundColor:Colors.blueAccent ,
       foregroundColor:Colors.blueAccent ,
       focusColor: Colors.blueAccent,
       focusElevation:2 ,
       onPressed:(){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatScreen( chatParams:ChatParams(currentUser.uid, user))));
       } ,
       elevation: 2,
       /*shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))
       ),*/

     ),
     body: Column(children: [
           SizedBox(height: 10,),
           // row du profile
           Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               children:[
                 Container(
                   padding: EdgeInsets.only(right: 10.0),
                   child: IconButton(
                     iconSize: 25,
                     color: Colors.white,
                     icon: Icon(Icons.clear,color: Colors.black,),
                     onPressed: (){
                       Navigator.of(context).pop(context);
                     },
                   ),
                 ),
                 Flexible(
                   child: Container(
                     child: Center(
                       child: Text("Profile",style: TextStyle(fontSize:20,color: Colors.blueAccent,fontStyle: FontStyle.normal,fontWeight: FontWeight.w200)),
                     ),
                   ),
                 ),
                 Container(
                     child:Padding(
                       padding: EdgeInsets.only(right:16),
                       child:Icon(Icons.wb_sunny,color: Colors.black),
                     )
                 )

               ] ),
           SizedBox(height: 30,),
           // padding image nom email
           Padding(
             padding:EdgeInsets.all(10.0),
             child: Column(
               children: [
                 ClipOval(child: Container(
                   width: 120,
                   height: 120,
                   child:_decideImageView(),
                 ),),
                 Container(
                   child: Text(paramsUser.modelUser.name,style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color: Colors.black),),
                 ),
                 Container(
                   child: Text(paramsUser.modelUser.email,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color: Colors.black),),
                 ),
               ],
             ),
           ),
           SizedBox(height: 20,),
           //padding du center
           SingleChildScrollView(


               child:Padding(
                 padding:EdgeInsets.all(5),
                 child: Container(

                     padding: EdgeInsets.only(left: 16,right: 16),
                     decoration: BoxDecoration(
                       color: Colors.black,
                       border: Border.all(color: Colors.grey,width: 1),
                       borderRadius: BorderRadius.circular(10),
                     ),

                     child:Column(
                       children: [
                         Padding(padding: EdgeInsets.all(8),
                           child: Container(
                             child:Column(
                               children: [
                                 Row(
                                   children: [
                                     Container(
                                       child:Icon(Icons.add_ic_call_rounded,color: Colors.white,),
                                     ),
                                     SizedBox(width: 10,),
                                     Container(
                                       child:Text("Telephone",style: TextStyle(color:Colors.white),),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   child: etatPhone?Text("+237.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color:Colors.white),):
                                   Text(paramsUser.modelUser.telephone,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color:Colors.white),),
                                 )
                               ],
                             ),
                           ),
                         ),
                         Divider(color: Colors.white,thickness:0.5,
                           height:1,),
                         Padding(padding: EdgeInsets.all(8),
                           child: Container(
                             child:Column(
                               children: [
                                 Row(
                                   children: [
                                     Container(
                                       child:Icon(Icons.add_location,color: Colors.white),
                                     ),
                                     SizedBox(width: 10,),
                                     Container(
                                       child: Text("Adresse",style:TextStyle(color:Colors.white)),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   child:etatAdress?Text("Information non renseigner.......",style:
                                   TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color: Colors.white),):
                                   Text(paramsUser.modelUser.adresse,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color:Colors.white),),
                                 )
                               ],
                             ),
                           ),
                         ),
                         Divider(color: Colors.white,thickness:0.5,
                           height:1,),
                         Padding(padding: EdgeInsets.all(8),
                           child: Container(
                             child:Column(
                               children: [
                                 Row(
                                   children: [
                                     Container(
                                       child:Icon(Icons.book_outlined,color: Colors.white),
                                     ),
                                     SizedBox(width: 10,),
                                     Container(
                                       child:Text("Religion",style:TextStyle(color:Colors.white)),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   child:etatReligion?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color:Colors.white),):
                                   Text(paramsUser.modelUser.religion,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color:Colors.white),),
                                 )
                               ],
                             ),
                           ),
                         ),
                         Divider(color: Colors.white,thickness:0.5,
                           height:1,),
                         Padding(padding: EdgeInsets.all(8),
                           child: Container(
                             child:Column(
                               children: [
                                 Row(
                                   children: [
                                     Container(
                                       child:Icon(Icons.book,color: Colors.white),
                                     ),
                                     SizedBox(width: 10,),
                                     Container(
                                       child:
                                       Text("Etudes",style:TextStyle(color:Colors.white)),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   child:etatEtudes?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color:Colors.white),):
                                   Text(paramsUser.modelUser.etudes,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color: Colors.white),),
                                 )
                               ],
                             ),
                           ),
                         ),
                         Divider(color: Colors.white,thickness:0.5,
                           height:1,),
                         Padding(padding: EdgeInsets.all(8),
                           child: Container(
                             child:Column(
                               children: [
                                 Row(
                                   children: [
                                     Container(
                                       child:Icon(Icons.merge_type,color: Colors.white),
                                     ),
                                     Container(
                                       child:Text("Taille",style:TextStyle(color:Colors.white)),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   child:etatTaille?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color:Colors.white),):
                                   Text(paramsUser.modelUser.taille,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color:Colors.white),),
                                 )
                               ],
                             ),
                           ),
                         ),
                         Divider(color: Colors.white,thickness:0.5,
                           height:1,),
                         Padding(padding: EdgeInsets.all(8),
                           child: Container(
                             child:Column(
                               children: [
                                 Row(
                                   children: [
                                     Container(
                                       child:Icon(FontAwesomeIcons.genderless,color: Colors.white),
                                     ),
                                     SizedBox(width: 10,),
                                     Container(
                                       child:
                                       Text("Statut",style:TextStyle(color:Colors.white)),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   child:etatStatut?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color:Colors.white),):
                                   Text(paramsUser.modelUser.statut,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color:Colors.white),),
                                 )
                               ],
                             ),
                           ),
                         ),
                         Divider(color: Colors.white,thickness:0.5,
                           height:1,),
                         Padding(padding: EdgeInsets.all(8),
                           child: Container(
                             child:Column(
                               children: [
                                 Row(
                                   children: [
                                     Container(
                                       child:Icon(FontAwesomeIcons.oldRepublic,color: Colors.white),
                                     ),
                                     SizedBox(width: 10,),
                                     Container(
                                       child:Text("Age",style:TextStyle(color:Colors.white)),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   child:etatAge?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color:Colors.white),):
                                   Text(paramsUser.modelUser.age,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color:Colors.white),),
                                 )
                               ],
                             ),
                           ),
                         ),
                         Divider(color: Colors.white,thickness:0.5,
                           height:1,),
                         Padding(padding: EdgeInsets.all(8),
                           child: Container(
                             child:Column(
                               children: [
                                 Row(
                                   children: [
                                     Container(
                                       child:Icon(Icons.wc_outlined,color: Colors.white),
                                     ),
                                     SizedBox(width: 10,),
                                     Container(
                                       child:Text("Sexe",style:TextStyle(color:Colors.white)),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   child:
                                   Text(paramsUser.modelUser.sexe,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100,color:Colors.white),),
                                 )
                               ],
                             ),
                           ),
                         ),
                       ],
                     )),
               )

             ),

         ],
         )

       ,

   );
  }
}