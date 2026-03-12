import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketFactory {
  static WebSocketChannel? _instance;
  static final String _url = 'ws://192.168.178.139:8080'; //PC IP

  //privater konstruktor
  SocketFactory._();

  /// Singleton-Instanz für WebSocketChannel abrufen oder erstellen
  static WebSocketChannel getInstance() {
    if (_instance == null) {
      _instance = IOWebSocketChannel.connect(_url);
    }
    return _instance!;
  }

  static void close() {
    _instance?.sink.close();
    _instance = null;
  }
}
