// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.image = 'assets/images/user.png',
    required this.online,
    required this.nombre,
    required this.email,
    required this.uid,
  });

  String image;
  bool online;
  String nombre;
  String email;
  String uid;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        image: json["image"],
        online: json["online"],
        nombre: json["nombre"],
        email: json["email"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "online": online,
        "nombre": nombre,
        "email": email,
        "uid": uid,
      };
}
