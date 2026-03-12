class SateliteSignal {
  static const double c = 0.299792458; // Lichtgeschwindigkeit in m/ns
  // GPS-Epoche: 6.1.1980, 00:00:00 UTC
  static const int gpsEpochOffsetSec =
      315964800; //Secounds between UNIX Time und GPS Time
  static const int NanosPerWeek = 604800000000000;

  SateliteSignal(
    this.svid,
    this.constellationType,
    this.signalType,
    this.timeNanos,
    this.fullBiasNanos,
    this.biasNanos,
    this.timeOffsetNanos,
    this.receivedSvTimeNanos,
    this.accumulatedDeltaRangeMeters,
    this.cn0DbHz,
    this.dopplerHz,
  ) : gnssTime = _calcGnssTime(
        timeNanos,
        fullBiasNanos,
        biasNanos,
        timeOffsetNanos,
      ),
      pseudorange = _calcPseudorange(
        timeNanos,
        fullBiasNanos,
        biasNanos,
        timeOffsetNanos,
        receivedSvTimeNanos,
      ),
      gpsWeek = _calcGpsWeek(
        timeNanos,
        fullBiasNanos,
        biasNanos,
        timeOffsetNanos,
      ),
      gpsNanosOfWeek = _calcGpsNanosOfWeek(
        timeNanos,
        fullBiasNanos,
        biasNanos,
        timeOffsetNanos,
      );
  //final dopplerHz = null
  //Todo: implementieren!!!!!!

  final int svid;
  final int constellationType; // z.B. 1=GPS, 3=GALILEO, ...
  final int? signalType; // z.B. "L1 -0 ", "L5 - ..."
  final int timeNanos;
  final int fullBiasNanos;
  final double biasNanos;
  final double? timeOffsetNanos;
  final int receivedSvTimeNanos;
  final double? accumulatedDeltaRangeMeters;
  final double? cn0DbHz;

  final int gnssTime; // Nanos seit GNSS-Epoche
  final double pseudorange; // Meter Typische werte 20 000 km-25 000 km
  final int gpsWeek;
  final int gpsNanosOfWeek;
  final double? dopplerHz; // Hz

  static int _calcGnssTime(
    int timeNanos,
    int fullBiasNanos,
    double biasNanos,
    double? timeOffsetNanos,
  ) {
    final offset = timeOffsetNanos ?? 0.0;

    int biasNanosInt = biasNanos.toInt();
    int timeOffsetNanosInt = offset.toInt();

    final int result =
        (timeNanos - fullBiasNanos - biasNanosInt - timeOffsetNanosInt
        // - leapSecond - Schon in FullBiasNanos abgezogen
        );

    return result;
  }

  static double _calcPseudorange(
    int timeNanos,
    int fullBiasNanos,
    double biasNanos,
    double? timeOffsetNanos,
    int receivedSvTimeNanos,
  ) {
    final gpsNanosOfWeek = _calcGpsNanosOfWeek(
      timeNanos,
      fullBiasNanos,
      biasNanos,
    );

    final double result =
        (gpsNanosOfWeek - receivedSvTimeNanos) * c; //ns * m/ns = m
    print(
      "Pseudorange: timeNanos: $timeNanos, fullBiasNanos: $fullBiasNanos,"
      " biasNanos: $biasNanos, timeOffsetNanos: $timeOffsetNanos,"
      "gpsNanosOfWeek: $gpsNanosOfWeek"
      "Pseudorange: $result",
    );

    return result; // in Metern
  }

  // GPS-Woche berechnen
  static int _calcGpsWeek(
    int timeNanos,
    int fullBiasNanos,
    double biasNanos, [
    double? timeOffsetNanos,
  ]) {
    final offset = timeOffsetNanos ?? 0.0;
    final gnssTimeNanos = _calcGnssTime(
      timeNanos,
      fullBiasNanos,
      biasNanos,
      offset,
    );
    final gpsWeek = (gnssTimeNanos / NanosPerWeek).floor();
    return gpsWeek;
  }

  // Nanos der aktuellen GPS-Woche
  static int _calcGpsNanosOfWeek(
    int timeNanos,
    int fullBiasNanos,
    double biasNanos, [
    double? timeOffsetNanos,
  ]) {
    final offset = timeOffsetNanos ?? 0.0;
    final int gnssTimeNanos = _calcGnssTime(
      timeNanos,
      fullBiasNanos,
      biasNanos,
      offset,
    );

    final int result = (gnssTimeNanos % NanosPerWeek);

    return result;
  }

  Map<String, dynamic> toJson() => {
    'svid': svid,
    'constellationType': constellationType,
    'signalType': signalType,
    'gpsWeek': gpsWeek,
    'gpsNanosOfWeek': gpsNanosOfWeek,
    'pseudorange': pseudorange,
    'carrierPhaseMeters': accumulatedDeltaRangeMeters,
    'dopplerHz': dopplerHz,
    'cn0DbHz': cn0DbHz,
  };
}
