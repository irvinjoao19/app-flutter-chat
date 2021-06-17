import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app_chat/global/environment.dart';

import 'package:app_chat/services/auth_services.dart';

import 'package:app_chat/models/usuario.dart';
import 'package:app_chat/models/mensajes_response.dart';

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    try {
      final token = await AuthService.getToken();
      final resp = await http.get(
        Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token == null ? "" : token
        },
      );
      final mensajeResponse = mensajeResponseFromJson(resp.body);
      return mensajeResponse.mensajes;
    } catch (e) {
      return [];
    }
  }
}
