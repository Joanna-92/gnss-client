import 'package:gnsslogger/Model/messages/socket_message.dart';

class PrecisePositionMessage extends SocketMessageCustom {
  PrecisePositionMessage();
  @override
  String get type => "precise Position Message";

  @override
  Map<String, dynamic> toJson() {
    Map<String, int> map1 = {'zero': 0, 'one': 1, 'two': 2};
    return map1;
  }
}
