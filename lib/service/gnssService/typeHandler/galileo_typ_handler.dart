import 'I_gnss_type_handle.dart';

class GalileoTypeHandler implements IGnssTypeHandler {
  static const l1Min = 1575420000 - 1000000; // ±1 MHz Toleranz
  static const l1Max = 1575420000 + 1000000;
  static const l2Min = 1278750000 - 1000000;
  static const l2Max = 1278750000 + 1000000;
  static const l5Min = 1207140000 - 1000000;
  static const l5Max = 1207140000 + 1000000;

  @override
  bool canHandle(int type) => type == 6; //GPS Type 1

  @override
  String get typeName => "Galileo";

  int? getSignalType(double? carrierFrequencyHz) {
    if (carrierFrequencyHz == null) return null;
    if (carrierFrequencyHz >= l1Min && carrierFrequencyHz <= l1Max) return 0;
    if (carrierFrequencyHz >= l2Min && carrierFrequencyHz <= l2Max) return 1;
    if (carrierFrequencyHz >= l5Min && carrierFrequencyHz <= l5Max) return 2;
    return -1;
  }
}
