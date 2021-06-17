import 'package:http/http.dart' as http;
import 'package:app_chat/global/environment.dart';
import 'package:app_chat/models/usuario.dart';
import 'package:app_chat/models/usuarios_response.dart';
import 'package:app_chat/services/auth_services.dart';

class UsuarioService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final token = await AuthService.getToken();
      final resp = await http.get(
        Uri.parse('${Environment.apiUrl}/usuarios'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token == null ? "" : token
        },
      );
      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
