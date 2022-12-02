





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Database_services/database.dart';
import '../../models/publication.dart';
import '../../models/user.dart';

class PublicationList extends StatefulWidget {
  _PublicationList createState()=> _PublicationList();
}
class _PublicationList extends State<PublicationList>{

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<Publication>>(context);

    final  name = TextEditingController();
    final  sexe= TextEditingController();
    final _formKey = GlobalKey<FormState>();
    String error = '';

    void toggleView() {
      setState(() {
        _formKey.currentState?.reset();// on vide le contenu dans le formulaire
        error = '';
        name.text = '';
        sexe.text = '';


      });
    }

    void Modal(BuildContext context) async{

      setState(() {
        showModalBottomSheet(
          // couleur de fond sur le reste de l'ecran l'orsque la modal monte
            barrierColor: Colors.white70,
            // backgroundColor: Colors.blueAccent,
            // donne la possibilite de scroller
            enableDrag: true,
            isDismissible:true,
            shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))
            ) ,
            context:context,
            // se souleve paraport au bas
            elevation: 30,
            isScrollControlled: true,
            builder: (_) => Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.only(
                top: 50,
                left: 50,
                right:50,
                // this will prevent the soft keyboard from covering the text fields
                // bottom: MediaQuery.of(context).viewPadding.bottom + 150,
                bottom:30,

              ),
              child:Form(
                key: _formKey,
                child:Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child:Text("Enregistrer un nouvelle Publication" ,style: TextStyle(fontSize: 25),),
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                            color: Colors.black
                        ),
                        controller: name,
                        obscureText: false,
                        decoration: InputDecoration(

                          // en cas d'erreur les bordure devienne rouge
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.red, width:1.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.red, width:1.0),
                          ),
                          // filled: true,
                          fillColor: Colors.white,
                          labelText: "Ajouter du contenu",labelStyle: TextStyle(color: Colors.blueAccent),
                          hintText: "partagez vos moments avec des amis",hintStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.symmetric(vertical: 50.5),

                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.blue, width:1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.blue, width:1.0),
                          ),
                        ),
                        validator:(value){
                          if(value!.isEmpty  || value.length<4){
                            return "Veuillez saisir un nom d'utilisateur(quatre lettres minimun)";
                          }
                          return null;
                        }

                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Text(""),

                      ],
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        onPrimary: Colors.white,
                        minimumSize: Size(double.infinity,50),
                      ),
                      onPressed: () async{

                        if (_formKey.currentState?.validate() == true) {

                          // on recupere les elements contenu dans dans les TextFormfield
                          var nameT=name.value.text;
                          var sexeT=sexe.value.text;


                          /*dynamic result = etatText
                          //on attribut la valeur de showsignin a result et valeur  par defaut true donc on aura seulement email et password a rechercher
                          // si non on insert les elements du formulaires
                              ? await _auth.signInWithEmailAndPassword(emailT, passwordT)
                              : await _auth.registerWithEmailAndPassword(nameT,sexeT, emailT, passwordT);*/
                        }

                      },
                      child: Text("Enregistrer"),
                    )
                  ],
                ),
              ),

            )
        );
      });

    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.blueAccent ,
        foregroundColor:Colors.blueAccent ,
        focusColor: Colors.blueAccent,
        focusElevation:2 ,
        onPressed: (){
          Modal(context);
        },
        // tooltip: 'Increment',
        child: const Icon(Icons.add,color: Colors.white,),
      ),
      body: ListView.builder(
          itemCount:users.length,
          itemBuilder: (context, index) {
            return lessProfileCurrrentUser(users[index]);
          }
      ),
    );

    // TODO: implement build

  }
}


class lessProfileCurrrentUser extends StatefulWidget {
  final  Publication publication ;

  lessProfileCurrrentUser(this.publication);

  _lessProfileCurrrentUser createState()=>_lessProfileCurrrentUser(publication);
}
class _lessProfileCurrrentUser extends State<lessProfileCurrrentUser>{
  final  Publication publication;
  _lessProfileCurrrentUser(this.publication);



  // element de modification de photo
  XFile? imageFile;

  _openCamera(BuildContext context) async{

    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    Navigator.of(context).pop();
    this.setState(() {
      imageFile=picture as XFile?;

    });
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    // Navigator.of(context).pop();
    this.setState(() {
      imageFile=picture as XFile?;
      String image=imageFile!.path;
    //  databasePublication.savePhoto(image);
    });

  }


 /* Future<void> _showChoixDialog(BuildContext context){
    return showDialog(context: context, builder:(BuildContext context){
      return AlertDialog(
        title: Text("Make a choix"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                child: Text("Gallery"),
                onTap: (){
                  _openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text("camera"),
                onTap: (){
                  _openCamera(context);
                },
              )
            ],
          ),
        ),
      );
    });
  }*/

 /* Widget _decideImageView(){
    if(appUserData.photo.toString().isEmpty){
      return Material(
        color: Colors.transparent,
        child: Ink.image(

          image: AssetImage('images/1.jpg'),
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap:(){
            showToast("message");
            // createDialog();
            _showChoixDialog;
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
        String image=appUserData.photo;
        return Image.network(image,width: 128,height: 128,);
        // return Text(appUserData.photo.toString());
      }else{
        // return Text(appUserData.photo.toString());
        return Image.file(File(imageFile!.path),width:128,height: 128,);
      }


    }
  }*/



  String dropdownReligion="";
  int R=0;
  var DropdownMenutemReligion=[
    '','catholique','protestant','musulmans','autres'
  ];



  bool etatModifie=true;
  final _formKey = GlobalKey<FormState>();

  Future showToast(String message) async{
    //   await Fluttertoast.cancel();
    Fluttertoast.showToast(msg: message,fontSize: 18,timeInSecForIosWeb: 1,textColor: Colors.black,gravity: ToastGravity.BOTTOM);

  }
  void createDialog()async{
    await CupertinoAlertDialog(
      title: Text(
        'Suppresion client',
        style: TextStyle(fontSize: 22),
      ),
      content:Text(
        'voulez vous vraiment supprimer ce client?',
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text('Yes'),
          onPressed: (){
            Navigator.pop(context,true);
          },
        ),

        CupertinoDialogAction(
          child: Text('No'),
          onPressed: (){
            Navigator.pop(context,false);
          },)
      ],
      //backgroundColor:Colors.blue,
      //   elevation: 24.0,
      // shape: CircleBorder(),

    );}



  @override
  Widget build(BuildContext context) {


    DatabasePublications databasePublication=DatabasePublications(publication.uid);

    final currentUser = Provider.of<AppUser?>(context);
    if (currentUser == null) throw Exception("current user not found");

    return  Scaffold()


      /*Form(
        key:_formKey,
        child:Column(children: [
          SizedBox(height: 10,),
          // padding image nom email
          Padding(
            padding:EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  width:Get.size.width,
                  margin: EdgeInsets.only(bottom: 10),
                  //height: 70,
                  *//* decoration: BoxDecoration(
                    shape:BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('images/1.jpg')
                    )
                ),*//*
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipOval(
                        child:_decideImageView()  ,),
                      Positioned(
                          bottom:5,
                          right:178,
                          child:Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white60),
                              color: Colors.lightBlue,
                              shape: BoxShape.circle,
                            ),

                            height: 30,
                            width: 30,
                            child: InkWell(
                              onTap: (){
                                _openGallery(context);
                                showToast("message");
                                createDialog();
                                // _showChoixDialog;
                              },
                              child: Icon(
                                Icons.edit,
                                size: 20,
                              ),),
                          )
                      )

                    ],
                  ),
                ),
                Container(
                  child: Text(appUserData.name,style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
                ),
                Container(
                  child: Text(appUserData.email,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          //padding du center
          Row(children:[
            Container(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(""),
            ),
            Flexible(
              child: Container(
                child: Center(
                  child: Text(""),
                ),
              ),
            ),
            Container(
              child: Padding(
                child: TextButton(
                  child: Text(etatModifie?"Modifier":"Sauvegarder",style: TextStyle(color: Colors.blueAccent,fontSize: 15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w200),),
                  onPressed: () {
                    setState(() {
                      if(etatModifie==true){
                        etatModifie=false;
                      }else if(etatModifie==false){
                        etatModifie=true;
                      }
                    });


                  },

                ),
                padding: EdgeInsets.only(right:16),
              ),
            )

          ] ),
          // padding des elements
          Padding(
            padding:EdgeInsets.all(5),
            child:Container(
              // color: Colors.white12,
                padding: EdgeInsets.only(left: 16,right: 16),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  border: Border.all(color: Colors.white12,width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(8),
                      child: Container(
                        child:Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child:Icon(Icons.add_ic_call_rounded,color: Colors.white),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  child:Text("Telephone"),
                                ),
                              ],
                            ),
                            Container(
                              child:etatModifie ? etatPhone?Text("+237.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                              Text(appUserData.telephone,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100)) :
                              TextFormField(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: etatPhoneSauv?"Veuillez inserer un numero":appUserData.telephone
                                ),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
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
                                  child:Text("Adresse"),
                                ),
                              ],
                            ),
                            Container(
                                child: etatModifie? etatAdress?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                                Text(appUserData.adresse,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),) :
                                TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: etatAdressSauv?"veuillez entrer une adresse":appUserData.adresse
                                  ),)
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
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
                                  child:Text("Religion"),
                                ),
                              ],
                            ),
                            Container(
                              child: etatModifie? etatReligion?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                              Text(appUserData.religion,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),) :
                              Container(
                                padding: EdgeInsets.only(left: 16,right: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:  Row(
                                  children: [
                                    Container(
                                      child:etatReligionSauv?Text("selectionner une religion"):Text(appUserData.religion),
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: Center(
                                          child: Text("",style: TextStyle(fontSize:20,color: Colors.white,fontStyle: FontStyle.normal,fontWeight: FontWeight.w200)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left:0),
                                      child: DropdownButton<String>(
                                          isExpanded: false,
                                          // dropdownColor: Colors.grey,
                                          value: dropdownReligion,
                                          icon: Icon(Icons.arrow_drop_down_sharp,size: 30,),
                                          elevation:10,
                                          style: TextStyle(color: Colors.white),
                                          underline: SizedBox(),
                                          //  underline: Container(height: 2,color: Colors.deepPurpleAccent,),
                                          onChanged: (String? newvalue){
                                            setState(() {
                                              dropdownReligion=newvalue!;
                                              showToast(newvalue);


                                              if(DropdownMenutemReligion[0]==newvalue){

                                              }

                                            });
                                          },
                                          items: DropdownMenutemReligion.map<DropdownMenuItem<String>>((String value){
                                            return
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                          }).toList()


                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
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
                                  child:Text("Etudes"),
                                ),
                              ],
                            ),
                            Container(
                              child: etatModifie?etatEtudes?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                              Text(appUserData.etudes,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),) :
                              Container(
                                padding: EdgeInsets.only(left: 16,right: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:  Row(
                                  children: [
                                    Container(
                                      child:etatEtudesSauv?Text("selectionner un diplome"):Text(appUserData.etudes),
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: Center(
                                          child: Text("",style: TextStyle(fontSize:20,color: Colors.white,fontStyle: FontStyle.normal,fontWeight: FontWeight.w200)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left:0),
                                      child: DropdownButton<String>(
                                          isExpanded: false,
                                          // dropdownColor: Colors.grey,
                                          value: dropdownEtudes,
                                          icon: Icon(Icons.arrow_drop_down_sharp,size: 30,),
                                          elevation:10,
                                          style: TextStyle(color: Colors.white),
                                          underline: SizedBox(),
                                          //  underline: Container(height: 2,color: Colors.deepPurpleAccent,),
                                          onChanged: (String? newvalue){
                                            setState(() {
                                              dropdownEtudes=newvalue!;

                                              if(DropdownMenutemEtudes[0]==newvalue){

                                              }

                                            });
                                          },
                                          items: DropdownMenutemEtudes.map<DropdownMenuItem<String>>((String value){
                                            return
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                          }).toList()


                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
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
                                  child:Text("Taille"),
                                ),
                              ],
                            ),
                            Container(
                              child: etatModifie? etatTaille?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                              Text(appUserData.taille,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),) :
                              Container(
                                padding: EdgeInsets.only(left: 16,right: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:  Row(
                                  children: [
                                    Container(
                                      child:etatTailleSauv?Text("selectionner une taille"):Text(appUserData.taille),
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: Center(
                                          child: Text("",style: TextStyle(fontSize:20,color: Colors.white,fontStyle: FontStyle.normal,fontWeight: FontWeight.w200)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left:0),
                                      child: DropdownButton<String>(
                                          isExpanded: false,
                                          // dropdownColor: Colors.grey,
                                          value: dropdownTaille,
                                          icon: Icon(Icons.arrow_drop_down_sharp,size: 30,),
                                          elevation:10,
                                          style: TextStyle(color: Colors.white),
                                          underline: SizedBox(),
                                          //  underline: Container(height: 2,color: Colors.deepPurpleAccent,),
                                          onChanged: (String? newvalue){
                                            setState(() {
                                              dropdownTaille=newvalue!;

                                              if(DropdownMenutemTaille[0]==newvalue){

                                              }

                                            });
                                          },
                                          items: DropdownMenutemTaille.map<DropdownMenuItem<String>>((String value){
                                            return
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                          }).toList()


                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
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
                                  child:Text("Statut"),
                                ),
                              ],
                            ),
                            Container(
                              child:etatModifie? etatStatut?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                              Text(appUserData.statut,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),) :
                              Container(
                                padding: EdgeInsets.only(left: 16,right: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:  Row(
                                  children: [
                                    Container(
                                      child:etatStatutSauv?Text("selectionner un Statut"):Text(appUserData.statut),
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: Center(
                                          child: Text("",style: TextStyle(fontSize:20,color: Colors.white,fontStyle: FontStyle.normal,fontWeight: FontWeight.w200)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left:0),
                                      child: DropdownButton<String>(
                                          isExpanded: false,
                                          // dropdownColor: Colors.grey,
                                          value: dropdownStatut,
                                          icon: Icon(Icons.arrow_drop_down_sharp,size: 30,),
                                          elevation:10,
                                          style: TextStyle(color: Colors.white),
                                          underline: SizedBox(),
                                          //  underline: Container(height: 2,color: Colors.deepPurpleAccent,),
                                          onChanged: (String? newvalue){
                                            setState(() {
                                              dropdownStatut=newvalue!;

                                              if(DropdownMenutemStatur[0]==newvalue){

                                              }

                                            });
                                          },
                                          items: DropdownMenutemStatur.map<DropdownMenuItem<String>>((String value){
                                            return
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                          }).toList()


                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
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
                                  child:Text("Age"),
                                ),
                              ],
                            ),
                            Container(
                              child: etatModifie? etatAge?Text("Information non renseigner.......",style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                              Text(appUserData.age,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),):
                              Container(
                                padding: EdgeInsets.only(left: 16,right: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:  Row(
                                  children: [
                                    Container(
                                      child:etatAgeSauv?Text("selectionner un age"):Text(appUserData.age),
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: Center(
                                          child: Text("",style: TextStyle(fontSize:20,color: Colors.white,fontStyle: FontStyle.normal,fontWeight: FontWeight.w200)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left:0),
                                      child: DropdownButton<String>(
                                          isExpanded: false,
                                          // dropdownColor: Colors.grey,
                                          value: dropdowAge,
                                          icon: Icon(Icons.arrow_drop_down_sharp,size: 30,),
                                          elevation:10,
                                          style: TextStyle(color: Colors.white),
                                          underline: SizedBox(),
                                          //  underline: Container(height: 2,color: Colors.deepPurpleAccent,),
                                          onChanged: (String? newvalue){
                                            setState(() {
                                              dropdowAge=newvalue!;

                                              if(DropdownMenutemAge[0]==newvalue){

                                              }

                                            });
                                          },
                                          items: DropdownMenutemAge.map<DropdownMenuItem<String>>((String value){
                                            return
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                          }).toList()


                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
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
                                  child:Text("Sexe"),
                                ),
                              ],
                            ),
                            Container(
                              child: Text(appUserData.name,style: TextStyle(fontSize:15,fontStyle: FontStyle.italic,fontWeight: FontWeight.w100),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(width: 35,),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink,
                          onPrimary: Colors.white,
                          minimumSize: Size(double.infinity,50),
                        ),
                        onLongPress: (){
                          showToast("heriol");
                        },
                        onPressed: (){
                          createDialog();

                        },
                        child: Text("Supprimer mon compte"),
                      ),
                    ),

                    SizedBox(width: 15,),



                  ],
                )
            ),

          ),
        ],
        ) ,
      )*/;


  }
}


