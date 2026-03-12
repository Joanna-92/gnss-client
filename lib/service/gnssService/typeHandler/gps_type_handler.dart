import 'I_gnss_type_handle.dart';

class GpsTypeHandler implements IGnssTypeHandler {
  @override
  bool canHandle(int type) => type == 1; //GPS Type 1

  @override
  String get typeName => "GPS";

  static const l1Min = 1575420000 - 1000000; // ±1 MHz Toleranz
  static const l1Max = 1575420000 + 1000000;
  static const l2Min = 1227600000 - 1000000;
  static const l2Max = 1227600000 + 1000000;
  static const l5Min = 1176450000 - 1000000;
  static const l5Max = 1176450000 + 1000000;

  int? getSignalType(double? carrierFrequencyHz) {
    if (carrierFrequencyHz == null) return -1;
    if (carrierFrequencyHz >= l1Min && carrierFrequencyHz <= l1Max) return 0;
    if (carrierFrequencyHz >= l2Min && carrierFrequencyHz <= l2Max) return 1;
    if (carrierFrequencyHz >= l5Min && carrierFrequencyHz <= l5Max) return 2;
    return -1;
  }
}
