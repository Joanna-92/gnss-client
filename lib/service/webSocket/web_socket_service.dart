import 'dart:async';
import 'package:gnsslogger/service/webSocket/socket_factory.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  late WebSocketChannel _channel;
  WebSocketChannel get instance => _channel;
  final StreamController<String> _controller =
      StreamController<String>.broadcast();

  WebSocketService() {
    _channel = SocketFactory.getInstance();
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  void listen(void Function(String) onMessage) {
    _channel.stream.listen((message) {
      print("Empfangen: $message");
      _controller.add(message as String);
      onMessage(message as String);
    });
  }

  void close() {
    SocketFactory.close();
  }

  Stream<String> get messageStream => _controller.stream.asBroadcastStream();
}
