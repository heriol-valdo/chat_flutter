

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/chat_params.dart';
import '../models/publication.dart';
import '../models/user.dart';


class DatabaseService{
  final String uid;

  DatabaseService(this.uid);

  final userUid=FirebaseAuth.instance.currentUser;


  final CollectionReference<Map<String, dynamic>> userCollection =
     // FirebaseFirestore.instance.collection("users").doc().collection("");
   //FirebaseFirestore.instance.collection("users").where(field);
  FirebaseFirestore.instance.collection("users");


  // supprime l'utilisayeur de maniere async en local er base externe
  Future<void> deleteUser() async {
     await userCollection.doc(uid).delete();
    /* await userCollection.doc(uid).collection("bordereau").doc(uid).delete();
     await userCollection.doc(uid)..collection("etat_stock").doc(uid).delete();*/

  }

 /* Future<void> saveToken(String? token) async {
    return await userCollection.doc(uid).update({'token': token});
  }
*/

  Future<void> saveUser(String name,String email,String telephone,String adresse,String religion,
      String etudes,String taille,String statut,String age,String sexe) async {
    /* await userCollection.doc(uid).collection("etat_stock").doc(uid).set({'quantite': name});
     await userCollection.doc(uid).collection("bordereau").doc(uid).set({'quantite': name});*/
    await userCollection.doc(uid).set({'name': name,'email':email,'telephone': telephone,'adresse': adresse,'religion': religion,'etudes':etudes,'taille': taille
      ,'statut': statut,'age': age,'sexe':sexe,'photo':""});

  }
  AppUserData _userFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");

    return AppUserData(
      uid: snapshot.id,
      name: data['name'],
      email: data['email'],
      telephone: data['telephone'],
      adresse: data['adresse'],
      religion: data['religion'],
      etudes: data['etudes'],
      taille: data['taille'],
      statut: data['statut'],
      age: data['age'],
      sexe: data['sexe'],
      photo: data['photo'] ,
    );
  }

  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  List<AppUserData>_userListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<AppUserData>> get users {
   return userCollection.where("email",isNotEqualTo:userUid!.email).snapshots().map(_userListFromSnapshot);
    //return userCollection.snapshots().map(_userListFromSnapshot);
  }


  Stream<List<AppUserData>> get userDrawer {
    return userCollection.where("email",isEqualTo:userUid!.email).snapshots().map(_userListFromSnapshot);
    // return userCollection.snapshots().map(_userListFromSnapshot);
  }

  Stream<List<AppUserData>> get userProfile {
    return userCollection.where("email",isEqualTo:userUid!.email).snapshots().map(_userListFromSnapshot);
    // return userCollection.snapshots().map(_userListFromSnapshot);
  }


   getDocument() async{
    final CollectionReference collectionReference =
    // FirebaseFirestore.instance.collection("users").doc().collection("");
    //FirebaseFirestore.instance.collection("users").where(field);
    FirebaseFirestore.instance.collection("users");

    Query query = collectionReference.where("email",isEqualTo: userUid!.email);

    QuerySnapshot querySnapshot = await query.get();

    final doc = querySnapshot.docs.map((doc) => doc['name']) ;

    var login=doc.toString();


    await login.toString();

   /* String login=doc.toString();

    login=login.substring(1, login.length-1);
*/
   /* if(heriol.toString().isEmpty){
      await heriol;

      return heriol=login;
    }else{
      await heriol;
      print(heriol=login);
     return heriol=login;
    }*/


    //print(login);

   // await login;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}


class DatabaseDiscussions {

  final userUid=FirebaseAuth.instance.currentUser;


  final CollectionReference<Map<String, dynamic>> userCollectionDiscussions =
  FirebaseFirestore.instance.collection("Discussions");


  getDocument(String uidDiscusions) async {

    final CollectionReference collectionReference =
    // FirebaseFirestore.instance.collection("users").doc().collection("");
    //FirebaseFirestore.instance.collection("users").where(field);
    FirebaseFirestore.instance.collection("users");

    Query query = collectionReference.where("email",isEqualTo: userUid!.email);

    QuerySnapshot querySnapshot = await query.get();

    final doc = querySnapshot.docs.map((doc) => doc['name']);

    var login=doc.toString();

    await   userCollectionDiscussions.doc(userUid!.uid).set({'name':login.substring(1, login.length-1).toString(),'usercurrentuid': uidDiscusions});

  }

  Future<void> saveDiscusions(String uidDiscusions,String nameUserDiscusions,String photoDiscusions) async {
    await userCollectionDiscussions.doc(uidDiscusions).set({'name': nameUserDiscusions,'photo': photoDiscusions,'usercurrentuid':userUid!.uid});
  }

  AppUserDiscussions _userFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("Discussions not found");
    return AppUserDiscussions(
      uid: snapshot.id,
      name: data['name'],
      photo: data['photo'],
    );
  }

  List<AppUserDiscussions>_userListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<AppUserDiscussions>> get usersDiscussions {
   return userCollectionDiscussions.where("usercurrentuid",isEqualTo:userUid!.uid).snapshots().map(_userListFromSnapshot);
    //return userCollectionDiscussions.snapshots().map(_userListFromSnapshot);
  }

}



class DatabaseProfile{
  final userUid=FirebaseAuth.instance.currentUser;


  final CollectionReference<Map<String, dynamic>> userCollection =
  // FirebaseFirestore.instance.collection("users").doc().collection("");
  //FirebaseFirestore.instance.collection("users").where(field);
  FirebaseFirestore.instance.collection("users");

  Future<void> saveToken(String telephone,String adresse,String religion,String etudes,String taille,String statut,String age) async {
    return await userCollection.doc(userUid!.uid).update({'telephone': telephone,'adresse': adresse,'religion': religion,'etudes':etudes,'taille': taille
    ,'statut': statut,'age': age});
  }

  /*Future<void> savePhoto(String name,String email,String telephone,String adresse,String religion,String etudes,String taille,String statut,String age,String photo) async {
    return await userCollection.doc(userUid!.uid).update({'name':name,'email':email,'telephone': telephone,'adresse': adresse,'religion': religion,'etudes':etudes,'taille': taille
      ,'statut': statut,'age': age,'photo':photo});
  }*/

  Future<void> savePhoto(String photo) async {
    return await userCollection.doc(userUid!.uid).update({'photo':photo});
  }

  Future<void> saveTelephoneAndAdressse(String telephone,String adresse) async {
    return await userCollection.doc(userUid!.uid).update({'telephone':telephone,'adresse':adresse});
  }

  Future<void> saveReligion(String religion) async {
    return await userCollection.doc(userUid!.uid).update({'religion':religion});
  }

  Future<void> saveEtudes(String etudes) async {
    return await userCollection.doc(userUid!.uid).update({'etudes':etudes});
  }
  Future<void> saveTaille(String taille) async {
    return await userCollection.doc(userUid!.uid).update({'taille':taille});
  }

  Future<void> saveStatut(String statut) async {
    return await userCollection.doc(userUid!.uid).update({'statut':statut});
  }
  Future<void> saveAge(String age) async {
    return await userCollection.doc(userUid!.uid).update({'age':age});
  }

  AppUserProfile _userFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");
    return AppUserProfile(
      uid: snapshot.id,
      name: data['name'],
      email: data['email'],
      telephone: data['telephone'],
      adresse: data['adresse'],
      religion: data['religion'],
      etudes: data['etudes'],
      taille: data['taille'],
      statut: data['statut'],
      age: data['age'],
      sexe: data['sexe'],
      photo: data['photo'],
    );
  }


  List<AppUserProfile>_userListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<AppUserProfile>> get users {
    return userCollection.where("email",isEqualTo:userUid!.email).snapshots().map(_userListFromSnapshot);
    //return userCollection.snapshots().map(_userListFromSnapshot);
  }
}


class DatabasePublications{


  final String uid;

  DatabasePublications(this.uid);

  final userUid=FirebaseAuth.instance.currentUser;


  final CollectionReference<Map<String, dynamic>> userCollection =
  FirebaseFirestore.instance.collection("publications");


  // supprime l'utilisayeur de maniere async en local er base externe
  Future<void> deleteUser() async {
    await userCollection.doc(uid).delete();
  }



  Future<void> saveUser(String name,String email,String telephone,String adresse,String religion,
      String etudes,String taille,String statut,String age,String sexe) async {
    await userCollection.doc(uid).set({'name': name,'email':email,'telephone': telephone,'adresse': adresse,'religion': religion,'etudes':etudes,'taille': taille
      ,'statut': statut,'age': age,'sexe':sexe,'photo':""});

  }
  Publication _userFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");

    return Publication(
      uid: snapshot.id,
    );
  }

  Stream<Publication> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  List<Publication>_userListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<Publication>> get users {
    return userCollection.where("email",isNotEqualTo:userUid!.email).snapshots().map(_userListFromSnapshot);

  }


  Stream<List<Publication>> get userDrawer {
    return userCollection.where("email",isEqualTo:userUid!.email).snapshots().map(_userListFromSnapshot);

  }

  Stream<List<Publication>> get userProfile {
    return userCollection.where("email",isEqualTo:userUid!.email).snapshots().map(_userListFromSnapshot);

  }


  getDocument() async{
    final CollectionReference collectionReference =
    // FirebaseFirestore.instance.collection("users").doc().collection("");
    //FirebaseFirestore.instance.collection("users").where(field);
    FirebaseFirestore.instance.collection("users");

    Query query = collectionReference.where("email",isEqualTo: userUid!.email);

    QuerySnapshot querySnapshot = await query.get();

    final doc = querySnapshot.docs.map((doc) => doc['name']) ;

    var login=doc.toString();


    await login.toString();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}