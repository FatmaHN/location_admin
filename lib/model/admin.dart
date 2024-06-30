import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Admin adminFromJson(String str) => Admin.fromJson(json.decode(str));

String adminToJson(Admin data) => json.encode(data.toJson());

class Admin {
  Admin({
    this.nom,
    this.email,
    this.uid,
  });

  String? nom;
  String? email;
  String? uid;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        nom: json["nom"],
        email: json["email"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "email": email,
        "uid": uid,
      };
  factory Admin.fromDoc(DocumentSnapshot doc) {
    return Admin(
      nom: doc['nom'],
      email: doc['email'],
      uid: doc.id,
    );
  }
}
