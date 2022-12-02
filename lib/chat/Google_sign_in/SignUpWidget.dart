import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/chat/View_page/Home_page/Acceuil.dart';


import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



import '../redirection/authentication.dart';
import 'GoogleSignInApi.dart';


class SignUpWidget extends StatefulWidget {

  _SignUpWidget createState() => _SignUpWidget();
}
class _SignUpWidget extends State<SignUpWidget>{
  final AuthenticationService _auth = AuthenticationService();
  bool etatText = true;
  bool etatSexe=true;
  int index = 0;

  // element de la modal

 
  final  name = TextEditingController();
  final  sexe= TextEditingController();
  final  email = TextEditingController();
  final  password = TextEditingController();
  final  passwordV = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  void toggleView() {
    setState(() {
      _formKey.currentState?.reset();// on vide le contenu dans le formulaire
       error = '';
      name.text = '';
      sexe.text = '';
      email.text = '';
      password.text = '';
      passwordV.text = '';

    });
  }





  void Modal(BuildContext context) async{
    setState(() {
      showModalBottomSheet(
       backgroundColor: Colors.black,
        // couleur de fond sur le reste de l'ecran l'orsque la modal monte
          barrierColor: Colors.white,
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
                    child:Text(etatText?"Se connecter" : "S'incrire" ,style: TextStyle(fontSize: 25,color: Colors.blueAccent),),
                  ),
                  const SizedBox(
                    height:20,
                  ),
                  etatText?Container(): TextFormField(
                      style: TextStyle(
                          color: Colors.white
                      ),
                      controller: name,
                      obscureText: false,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                            child:   Icon(Icons.account_circle_rounded,color: Colors.blue,),
                            padding: EdgeInsets.all(8)
                        ),
                        // en cas d'erreur les bordure devienne rouge
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.red, width:1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.red, width:1.0),
                        ),
                       // filled: true,
                        fillColor: Colors.white,
                        //prefixText: 'nfjkf',

                        labelText: "Nom utilisateur",labelStyle: TextStyle(color: Colors.blueAccent),
                        hintText: "entrer un nom d'utilisateur",hintStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),

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

                  etatText? Container():const SizedBox(height: 15,),

                  etatText?Container():  TextFormField(
                      style: TextStyle(
                          color: Colors.white
                      ),
                      controller: sexe,
                      obscureText: false,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                            child:   Icon(Icons.transgender,color: Colors.blue,),
                            padding: EdgeInsets.all(8)
                        ),
                        // en cas d'erreur les bordure devienne rouge
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.red, width:1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.red, width:1.0),
                        ),
                        // filled: true,
                        fillColor: Colors.white,
                        //prefixText: 'nfjkf',

                        labelText: "Sexe de l'utilisateur",labelStyle: TextStyle(color: Colors.blueAccent),
                        hintText: "exemple: Masculin,feminin,autres",hintStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),

                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.blue, width:1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.blue, width:1.0),
                        ),
                      ),
                      validator:(value){
                        if(value!.isEmpty || value.length<5){
                          return "Veuillez saisir un element en exemple";
                        }else{

                           if(value=="masculin" || value=="Masculin" ){
                             return null;
                           }else if(value=="feminin" || value=="Feminin"){
                             return null;
                           }else if(value=="autres" || value=="Autres"){
                             return  null;
                           }else if(value!="masculin" || value!="Masculin"
                           || value!="Feminin" || value!="feminin" || value!="Aures" || value!="autres"){
                             return "Veuillez saisir un element en exemple";
                           }


                        }

                      }

                  ),
                  etatText? Container():const SizedBox(height: 15,),
                  TextFormField(
                      style: TextStyle(
                          color: Colors.white
                      ),
                      controller: email,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                            child:   Icon(Icons.markunread,color:Colors.blue),
                            padding: EdgeInsets.all(8)
                        ),
                        // en cas d'erreur les bordure devienne rouge
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.red, width:1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(

                          borderSide: BorderSide(color:Colors.red, width:1.0),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.blue, width:1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors.blue, width:1.0),
                        ),
                        //filled: true,
                        fillColor: Colors.black,
                        labelText: "Email",labelStyle: TextStyle(color: Colors.blueAccent),
                        hintText: "entrer votre Email",hintStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator:(value){
                        if(value!.isEmpty){
                          return 'Veuillez saisir un Email valide';
                        }
                        return null;
                      }

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(
                        color: Colors.white
                    ),
                    controller:password,
                    obscureText: true,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                          child:   Icon(Icons.visibility_off_sharp,color:Colors.blue),
                          padding: EdgeInsets.all(8)
                      ),
                      // en cas d'erreur les bordure devienne rouge
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:Colors.red, width:1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:Colors.red, width:1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:Colors.blue, width:1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:Colors.blue, width:1.0),
                      ),

                      //filled: true,
                      fillColor: Colors.white,
                      labelText: "mot de passe",labelStyle: TextStyle(color: Colors.blueAccent),
                      hintText: "entrer votre mot de passe",hintStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty || value.length<6) {
                        return 'veuillez entrer au moins 6 characteres';
                      }
                      return null;
                    },
                  ),
                  etatText? Container():const SizedBox(height: 15),

                  etatText?Container():TextFormField(
                    style: TextStyle(
                      color: Colors.white
                    ),
                    controller:passwordV,
                    obscureText: true,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                          child:   Icon(Icons.vpn_key_rounded,color:Colors.blue),
                          padding: EdgeInsets.all(8)
                      ),
                      // en cas d'erreur les bordure devienne rouge
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:Colors.red, width:1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:Colors.red, width:1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:Colors.blue, width:1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:Colors.blue, width:1.0),
                      ),
                      //filled: true,
                      fillColor: Colors.white,
                      labelText: "mot de passe de verification",labelStyle: TextStyle(color: Colors.blueAccent),
                      hintText: "verifier le mot de passe",hintStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value){
                      if(value!=password.value.text) {
                        return 'veuillez entrer le meme mot de passe';
                      }
                      return null;
                    },
                  ),
                  etatText? Container():const SizedBox(height: 20,),


                  const SizedBox(height: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                     // primary: Colors.blueAccent,
                   //   onPrimary: Colors.white,
                      minimumSize: Size(double.infinity,50),
                    ),
                    onPressed: () async{
                      if (_formKey.currentState?.validate() == true) {

                        // on recupere les elements contenu dans dans les TextFormfield
                        var nameT=name.value.text;
                        var sexeT=sexe.value.text;
                        var emailT=email.value.text;
                        var passwordT=password.value.text;

                        dynamic result = etatText
                        //on attribut la valeur de showsignin a result et valeur  par defaut true donc on aura seulement email et password a rechercher
                        // si non on insert les elements du formulaires
                            ? await _auth.signInWithEmailAndPassword(emailT, passwordT)
                            : await _auth.registerWithEmailAndPassword(nameT,sexeT, emailT, passwordT);


                        if(result!=null){
                          setState(() {
                            etatText ? Navigator.of(context).pop() :
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Acceuil() ));
                          });

                        }

                       else if (result == null ) {
                          //  loading = false;
                          etatText? showToast("veuillez entrer un email et mot de passe valide") : showToast("Ce mail est invalide ou il doit deja etre utiliser");

                        };

                      }
                      // Close the bottom sheet

                    },
                    child: Text(etatText ? "connecter" : "inscription"),
                  )
                ],
              ),
            ),

          )
      );
    });

  }

  Future showToast(String message) async{

    await   Fluttertoast.showToast(msg: message,fontSize: 18,
      timeInSecForIosWeb:3,textColor: Colors.white,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black45,
      webPosition:"center",
    );

  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(

        padding: EdgeInsets.all(32),

        child:  Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Column(
                children: [
                FaIcon(FontAwesomeIcons.mailBulk,size: 120,color: Colors.blueAccent,),
                  SizedBox(height:0),
                  Align(
                    alignment:  Alignment.center,
                    child: Text(
                        'chat me',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:30,
                          fontWeight: FontWeight.w100,
                        )
                    ),
                  ),
                ],
              ),
            ),

            //FlutterLogo(size: 120),
            Spacer(),
            Center(
              child:Align(
                alignment:  Alignment.center,
                child: Text(
                    'Bienvenue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:17,
                      fontWeight: FontWeight.w500,
                    )
                ),
              ),
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Chat me est le meilleur lieu pour faire des recontres!',
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.w100,color: Colors.white),
              ),
            ),
            SizedBox(height:25),
            Expanded(child: Container(
              child:  ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                //  primary: Colors.blueAccent,
                //  onPrimary: Colors.white,
                  minimumSize: Size(double.infinity,50),
                ),
                icon: FaIcon(FontAwesomeIcons.mailBulk,color: Colors.white,),
                label: Text('Email & Mot de passe'),
                onPressed: (){
                  toggleView();
                  Modal(context);
                  etatText=true;
                },
              ),
            )),

             SizedBox(height: 15),
           Expanded(child:  ElevatedButton.icon(
             style: ElevatedButton.styleFrom(
               //primary: Colors.white,
              // onPrimary: Colors.black,
               minimumSize: Size(double.infinity,50),
             ),
             icon: FaIcon(FontAwesomeIcons.google,color: Colors.red,),
             label: Text('Connection avec Google'),
             onPressed: (){

               signIn();
             },
           )),
            SizedBox(height: 15),
           Expanded(child:  ElevatedButton(
             style: ElevatedButton.styleFrom(
             //  primary: Colors.blueAccent,
              // onPrimary: Colors.white,
               minimumSize: Size(double.infinity,50),
             ),
             child:TextButton(
               onPressed: () {
                 Modal(context);
                 etatText=false;
               },
               child:RichText(
                 text: TextSpan(
                   text: "S'inscrire",
                   style: TextStyle(color: Colors.white,
                       fontWeight: FontWeight.w100),
                 ),
               ),
             ),
             onPressed: (){
               toggleView();
               Modal(context);
               etatText=false;
             },
           )),
          Expanded(child:   SizedBox(height: 50)),

           Expanded(
             child:  InkWell(
                 onTap: (){
                   setState(() {
                     toggleView();
                     Modal(context);
                     etatText=true;
                   });

                 },
                 child: RichText(

                   text: TextSpan(
                     style: TextStyle(color: Colors.white,
                         fontWeight: FontWeight.w100),
                     text: 'Vous avez deja un compte ?  ',
                     children: [
                       TextSpan(
                         text: 'Connectez-vous ici.',
                         style: TextStyle(decoration: TextDecoration.underline,color: Colors.white,fontWeight: FontWeight.w500),
                       ),
                     ],
                   ),
                 )
             ),
           )
          ],
        ),
      ),
    );
  }

  Future signIn() async{
    await GoogleSignInApi.login();
  }

}




