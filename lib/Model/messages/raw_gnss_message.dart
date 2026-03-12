import 'package:gnsslogger/Model/messages/socket_message.dart';
import '../satelite_signal.dart';

class RawGnssMessage extends SocketMessageCustom {
  final SateliteSignal payload;

  RawGnssMessage(this.payload);

  @override
  String get type => 'raw_gnss';

  @override
  Map<String, dynamic> toJson() => {'type': type, 'payload': payload.toJson()};
}
