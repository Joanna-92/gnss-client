abstract class IGnssTypeHandler {
  bool canHandle(int type);
  String get typeName;

  int? getSignalType(double? carrierFrequencyHz);
}
