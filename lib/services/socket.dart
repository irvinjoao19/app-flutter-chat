import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:app_chat/global/environment.dart';
import 'package:app_chat/services/auth_services.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  //List<Band> get bands => this._bands;
  IO.Socket get socket => this._socket;

  void connect() async {
    final token = await AuthService.getToken();

    this._socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token}
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    this._socket.on('nuevo-mensaje', (payload) {
      print('nuevo mensaje : $payload');
    });

    /*  this._socket.on('active-bands', (bands) {
      this._bands = bandToList(bands);
      notifyListeners();
    }); */
  }

  void disconnect() {
    this._socket.disconnect();
  }
}
