import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ces deux fonctions sont pour la conversion de données de type json en objet et inversement

Admin adminFromJson(String str) => Admin.fromJson(json.decode(str));

String adminToJson(Admin data) => json.encode(data.toJson());

class Admin{
  Admin({
    this.nom,
    this.email,
    this.uid,
  });

  String? nom;
  String? email;
  String? uid;
//créer un objet admin à partir d'un objet json

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        nom: json["nom"],
        email: json["email"],
        uid: json["uid"],
      );
//convertir un objet admin en objet JSON 
  Map<String, dynamic> toJson() => {
        "nom": nom,
        "email": email,
        "uid": uid,
      };
//fromDoc est une méthode de création à partir de DocumentSnapshot, cette méthode spécifique pour firestore 
//cette méthode pour récupérer des données à partir de document firestore, et le convertir en un objet utilisable dans une app flutter
   factory Admin.fromDoc(DocumentSnapshot doc) {
     return Admin(
       nom: doc['nom'],
       email: doc['email'],
       uid: doc.id,
       );
   }   
}