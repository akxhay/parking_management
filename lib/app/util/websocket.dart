import 'dart:async';
import 'dart:developer';
import 'dart:io';

import '../data/constants/api_constants.dart';


class WebsocketController {
  static final WebsocketController _singleton = WebsocketController._internal();

  StreamController<String> streamController =
      StreamController.broadcast(sync: true);

  WebSocket? channel;

  factory WebsocketController() {
    return _singleton;
  }

  WebsocketController._internal() {
    initWebSocketConnection();
  }

  Future<void> initWebSocketConnection() async {
    log("connecting...");
    channel = await connectWs();
    log("socket connection initialized");
    channel!.done.then((dynamic _) => _onDisconnected());
    broadcastNotifications();
  }

  void broadcastNotifications() {
    channel!.listen((streamData) {
      log('Received data: $streamData');
      streamController.add(streamData);
    }, onDone: () {
      log("connecting aborted");
      initWebSocketConnection();
    }, onError: (e) {
      log('Server error: $e');
      initWebSocketConnection();
    });
  }

  Future<WebSocket> connectWs() async {
    try {
      return await WebSocket.connect(await ApiConstants.getWebSocketUrl());
    } catch (e) {
      log("Error! can not connect WS connectWs $e");
      await Future.delayed(const Duration(milliseconds: 10000));
      return await connectWs();
    }
  }

  void _onDisconnected() {
    initWebSocketConnection();
  }
}
