import '../satelite_signal.dart';

class ObsMessage {
  final String type = "epoch_obs";
  final int gpsWeek;
  final int gpsTow; // GPS Time of Week in nanoseconds
  final List<SateliteSignal> obs;

  ObsMessage({required this.gpsWeek, required this.gpsTow, required this.obs});

  Map<String, dynamic> toJson() => {
    'type': type,
    'gpsWeek': gpsWeek,
    'gpsTow': gpsTow,
    'obser': obs
        .map(
          (sat) => {
            'constellationType': sat.constellationType,
            'svid': sat.svid,
            'signalType': sat.signalType,
            'pseudorange': sat.pseudorange,
            'carrierPhase': sat.accumulatedDeltaRangeMeters,
            'doppler': sat.dopplerHz,
            'cn0DbHz': sat.cn0DbHz,
          },
        )
        .toList(),
  };
}
