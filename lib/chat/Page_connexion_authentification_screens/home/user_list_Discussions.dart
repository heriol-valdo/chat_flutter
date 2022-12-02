import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


import '../../models/chat_paramsDiscussions.dart';
import '../../models/user.dart';
import '../chat/chat_screenDiscussions.dart';

class UserListDiscuusions extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserListDiscuusions> {
    @override
  Widget build(BuildContext context) {
      final users = Provider.of<List<AppUserDiscussions>>(context);
      return ListView.builder(
          itemCount:users.length,
          itemBuilder: (context, index) {
            return UserTile(users[index]);
          }
      );
  }
}


class UserTile extends StatelessWidget {
  final AppUserDiscussions user;

  UserTile(this.user);

  Widget _decideImageView(){
    if(user.photo.toString().isEmpty){
      return Material(
        color: Colors.transparent,
        child:  ClipOval(
          child: Ink.image(
            image: AssetImage('images/1.jpg'),
            fit: BoxFit.cover,
            width: 47,
            height: 47,
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
        String image=user.photo;
        return Image.network(image,width: 47,height: 47,);

      }else{
        String image=user.photo;
        return Image.network(image,width: 47,height: 47,);
        /*  XFile? imageFile=appUserData.photo as XFile?;

        return Image.file(File(imageFile!.path),width:120,height: 120,);
      */}


    }
  }
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AppUser?>(context);
    if (currentUser == null) throw Exception("current user not found");
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreenDiscussions( chatParamsDiscussions:ChatParamsDiscussions(currentUser.uid, user))));
             },

      child: Padding(
          padding: const EdgeInsets.only(top:0.0),
        child: Card(
          shadowColor: Colors.blueAccent,
         // color: Colors.red,
          elevation: 8.0,
          margin: EdgeInsets.only(top:1.0, bottom: 0.0, left:1.0, right:1.0),
          child: Column(
           // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Row(
              children: [
                Padding(
                  child: ClipOval(
                    child: Container(
                      width: 47,
                      height: 47,
                      child: _decideImageView(),
                    ),
                  ),
                    padding:EdgeInsets.all(5.0),
                ),
                /*Container(
                  margin: EdgeInsets.only(left:10,bottom:15,top: 10),
                  //height:0,
                  child: Image.asset('images/1.jpg',height: 70,fit: BoxFit.cover,width:60,),
                  decoration: BoxDecoration(
                      shape:BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('images/1.jpg')
                      )
                  ),
                ),*/

                SizedBox(width: 5,),
                Container(child:Text(user.name,style: TextStyle(fontSize:15),),)


              ],
            )
             // Text('Statut ${user.waterCounter} all users'),
            ],
          ),
        )
      )
    );
  }
}
