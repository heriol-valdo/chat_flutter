// ignore_for_file: equal_elements_in_set

import 'package:apk_admin/apk_admin.dart';
import 'package:enume/enume.dart';
import 'package:enume/enume.dart';
import 'package:enume/enume.dart';
import 'package:enume/enume.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';


import '../../Database_services/database.dart';
import '../../Google_sign_in/SignUpWidget.dart';
import '../../models/publication.dart';
import '../../models/user.dart';
import '../../Page_connexion_authentification_screens/home/user_list.dart';
import '../../Page_connexion_authentification_screens/home/user_list_Discussions.dart';
import '../../redirection/authentication.dart';
import '../Drawer_name_and_picture/Drawer_name.dart';
import '../Drawer_name_and_picture/Drawer_picture.dart';
import '../ProfileUserCurrent/ProfileCurrentUser.dart';
import '../Publication/PublicationList.dart';





class Acceuil extends StatefulWidget {
  _Acceuil createState()=> _Acceuil();
}

class _Acceuil extends State<Acceuil>{
  final AuthenticationService _auth = AuthenticationService();
  final currentUserEmailAndPassword=FirebaseAuth.instance.currentUser;

  
  bool etatAppbarAcceuil=true;
  bool etatDisPub=true;
  bool etatProfile=true;

  //element du navigationbutton
  int _currentIndex=0;





  @override
  Widget build(BuildContext context) {

    final username = Provider.of<AppUser?>(context);
    if (username == null) throw Exception("user not found");
    final database = DatabaseService(username.uid);

    final currentUser = Provider.of<AppUser?>(context);
    if (currentUser == null) throw Exception("current user not found");

    DatabaseDiscussions databaseDiscussions= DatabaseDiscussions();

    final databaseProfile=DatabaseProfile();
    final databasePublications=DatabasePublications(username.uid);


    final tabs=[etatProfile? Container(
        child:Center(child:StreamProvider<List<AppUserData>>.value(
            initialData: [],
            value: database.users,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: UserList(),
            ),
          ) )) :
   Container(
        child:Center(child:StreamProvider<List<AppUserProfile>>.value(
          initialData: [],
          value: databaseProfile.users,
          child: Scaffold(
           // backgroundColor: Colors.white,
            body: ProfileCurrentUser(),
          ),
        ) )) ,

      etatDisPub?Container(
          child:Center(child:StreamProvider<List<Publication>>.value(
            initialData: [],
            value: databasePublications.users,
            child: Scaffold(
              // backgroundColor: Colors.white,
              body: PublicationList(),
            ),
          ) )) :  Container(child:StreamProvider<List<Publication>>.value(
                initialData: [],
                value: databasePublications.users,
                child: Scaffold(
                // backgroundColor: Colors.white,
                body: PublicationList(),
                ),
                ) ),

      etatProfile?   Container(
            child:Center(child:StreamProvider<List<AppUserDiscussions>>.value(
              initialData: [],
              value: databaseDiscussions.usersDiscussions,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: UserListDiscuusions(),
              ),
            ) )) : Container(
          child:Center(child:StreamProvider<List<AppUserProfile>>.value(
            initialData: [],
            value: databaseProfile.users,
            child: Scaffold(
              // backgroundColor: Colors.white,
              body: ProfileCurrentUser(),
            ),
          ) )),
    ];



    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (BuildContext context){
            return  Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Flexible(
                      flex: 200,
                      child: Container(
                    width:50,
                    child:IconButton(
                      icon:Icon(Icons.account_circle_rounded,size:30,),
                      onPressed: () {
                       // database.getDocument();
                        Scaffold.of(context).openDrawer();
                        },
                      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                    ),
                      )
                  ),
                ],
              ),);
          },
        ),
        title: Row(
          children: [
            Flexible(
                child: Container(
               // width: 400,
                child:  Center(
                  child: etatAppbarAcceuil ?FaIcon(FontAwesomeIcons.mailBulk,size:32,color: Colors.blueAccent,):
                  etatDisPub?Text("Publications",style: TextStyle(fontSize:20,color: Colors.blueAccent))
                          :Text("Discussions",style: TextStyle(fontSize:20,color: Colors.blueAccent),),
                )

            )
            ),
            Container(
            //  width: 50,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.settings,size: 30)),
            )
          ],
        ),
      ),
      body:Column(children: [
          Container(
           // height: 508,
            child: Flexible(child:tabs[_currentIndex]),),
          //Expanded(child: Divider(), )
        ]
      ),

      bottomNavigationBar: BottomNavigationBar(
        //selectedItemColor: Colors.blueAccent,
        backgroundColor: Colors.black,
        fixedColor: Colors.blueAccent,
        currentIndex: _currentIndex,
        // pour que la couleur du bottomNavigation change en fonction de l'item
       // type: BottomNavigationBarType.shifting,
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.orange,
        iconSize:20,
       // selectedFontSize:0,
       // unselectedFontSize:0,
        items: [
          BottomNavigationBarItem(
            backgroundColor:Colors.blue,
            tooltip:MaterialLocalizations.of(context).okButtonLabel,
            label:"",
           // label:"home",
            icon: Icon(Icons.water_damage,color: Colors.white,),
          ),

          BottomNavigationBarItem(
            backgroundColor:Colors.greenAccent,
            label:"",
          //  label:"publication",
            icon: Icon(Icons.web_rounded,
              color: Colors.white,),
          ),

          BottomNavigationBarItem(
            backgroundColor:Colors.orange,
            label:"",
          //  label:"message",
            icon: Icon(Icons.email,color:Colors.white,),
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex=index;
            if(_currentIndex==2){
              etatProfile=true;
              etatAppbarAcceuil=false;
              etatDisPub=false;
            }else if(_currentIndex==0){
              etatProfile=true;
              etatAppbarAcceuil=true;
            }else if(_currentIndex==1){
              etatProfile=true;
              etatAppbarAcceuil=false;
              etatDisPub=true;
            }
          });


        },
      ),

     drawer:  Drawer(
      backgroundColor: Colors.black87,
       elevation: 8.0,
       child: Container(
         child: Container(
           color: Colors.black87,
           child: Column(
             children: [
               // container header
               Container(
                 color: Colors.black87,
                 //height: 200,
                 padding: EdgeInsets.only(top: 15.0),
                 child: InkWell(
                   onTap: (){
                     setState(() {
                       etatProfile=false;
                       _currentIndex=0;
                     });

                     Navigator.pop(context);
                   },

                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Container(
                         color: Colors.black,
                         height: 120,
                         width: 120,

                             child:StreamProvider<List<AppUserProfile>>.value(
                               initialData: [],
                               value: databaseProfile.users,
                               child: Drawer_picture(),

                             )
                         ),
                       Container(
                         color: Colors.black,
                         height: 15,
                         child:StreamProvider<List<AppUserProfile>>.value(
                             initialData: [],
                             value: databaseProfile.users,
                             child:Center(child: Drawer_name(),)

                         ) ,),
                       // Text("" ,style: TextStyle(fontSize:10,color: Colors.white),),

                     ],
                   ),
                 ),
               ),
               Container(
                   color: Colors.black,
                   child:  Text(currentUserEmailAndPassword!.email!,style: TextStyle(fontSize:14,color: Colors.grey[200]),)),
               Divider(thickness: 1,color: Colors.black,),
             Container(
               height: 10,
                 color: Colors.black,
                 ),


               // element de la liste
               InkWell(
                 splashColor: Colors.black87,
                 child:  Container(
                   color: Colors.black,
                   height:30,
                   child: Row(
                     children: [
                       Container(width: 60,child: Icon(Icons.account_circle_outlined,size:30,color: Colors.white,)),
                       Container(width:200,child: Text("Profil",style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.w500),)),
                     ],
                   ),

                 ),
                 onTap: (){
                   setState(() {
                    etatProfile=false;
                    _currentIndex=0;
                   });

                   Navigator.pop(context);
                 },
               ),
               Container(
                 height: 20,
                 color: Colors.black,
               ),

               InkWell(
                 child:  Container(
                   color: Colors.black,
                   height:30,
                   child: Row(
                     children: [
                       Container(width: 60,child: Icon(Icons.add_location_alt_outlined,size:30,color: Colors.white,)),
                       Container(width:200,child: Text("Mes publications",style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.w500),)),
                     ],
                   ),

                 ),
                 onTap: (){
                   setState(() {
                     etatDisPub=false;
                     _currentIndex=1;

                   });
                   Navigator.pop(context);
                 },
               ),
               Container(
                 height: 15,
                 color: Colors.black,
               ),

               InkWell(
                 child:  Container(
                   color: Colors.black,
                   height:30,
                   child: Row(
                     children: [
                       Container(width: 60,child: Icon(Icons.category_outlined,size:30,color: Colors.white,)),
                       Container(width:200,child: Text("categories",style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.w500),)),
                     ],
                   ),

                 ),
                 onTap: (){
                   Navigator.pop(context);
                 },
               ),
               Container(
                 height: 55,
                 color: Colors.black,
               ),

               Divider(thickness:0.5,
                 height:1,color: Colors.grey,),
               Container(
                 height: 12,
                 color: Colors.black,
               ),

               InkWell(
                 child:  Container(
                   color: Colors.black,
                   height:30,
                   child: Row(
                     children: [
                       Container(width: 20,),
                       Center(child:
                       Container(width:280,child: Text("Centre d'assistance",style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.w500),)),),
                     ],
                   ),

                 ),
                 onTap: (){
                   Navigator.pop(context);
                 },
               ),
               Container(
                 height: 20,
                 color: Colors.black,
               ),

               InkWell(
                 child:  Container(
                   color: Colors.black,
                   height:30,
                   child: Row(
                     children: [
                       Container(width: 60,child: Icon(Icons.login_sharp,size:25,color: Colors.red,)),
                       Container(width:200,child: Text("se deconnecter",style: TextStyle(color: Colors.red,fontSize:20,fontWeight: FontWeight.w500),)),
                     ],
                   ),

                 ),
                 onTap: (){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                       SignUpWidget()));
                   _auth.signOut();

                 },
               ),

             ],
           ),
         ),
       ),

     ),
    );
  }
}


