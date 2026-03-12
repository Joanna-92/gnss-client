// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:raw_gnss/raw_gnss.dart';
import '../../Model/satelite_signal.dart';
import '../../Model/messages/obs_message.dart';
import '../webSocket/web_socket_service.dart';
import 'I_gnss_service.dart';
import 'typeHandler/I_gnss_type_handle.dart';

class GnssServiceImpl implements IGnssService {
  final List<IGnssTypeHandler> _handlers = [];
  StreamSubscription? _subscriptionObs;
  WebSocketService wsService = WebSocketService();

  // Epoch
  List<SateliteSignal> _currentEpochObs = [];
  int? _currentGpsWeek;
  int? _currentGpsTow;

  GnssServiceImpl();

  @override
  void start(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Listener started, data is being send continuously to server",
        ),
      ),
    );

    if (_subscriptionObs != null) return;

    _subscriptionObs = RawGnss().gnssMeasurementEvents.listen((e) async {
      for (var m in e.measurements!) {
        for (var handler in _handlers) {
          if (handler.canHandle(m.constellationType!)) {
            int? signalType = handler.getSignalType(m.carrierFrequencyHz);

            if (!({1, 9, 25}.contains(m.accumulatedDeltaRangeState))) {
              print(
                "Signal ${m.svid} unuseble becouse of ADR",
              ); //accumulatedDeltaRangeState says if there are cycle slip
              continue;
            }

            if (m.svid != null &&
                m.constellationType != null &&
                m.receivedSvTimeNanos != null &&
                e.clock?.timeNanos != null &&
                e.clock?.fullBiasNanos != null &&
                e.clock?.biasNanos != null) {
              SateliteSignal signal = SateliteSignal(
                m.svid!,
                m.constellationType!,
                signalType,
                e.clock!.timeNanos!,
                e.clock!.fullBiasNanos!,
                e.clock!.biasNanos!,
                m.timeOffsetNanos,
                m.receivedSvTimeNanos!,
                m.accumulatedDeltaRangeMeters,
                m.cn0DbHz,
                m.pseudorangeRateMetersPerSecond,
              );

              // Calculate current epoch time
              final gpsWeek = signal.gpsWeek;
              final gpsTow = signal.gpsNanosOfWeek; // Kept in nanoseconds

              // Check if this is a new epoch (different second)
              if (_currentGpsWeek != gpsWeek ||
                  (_currentGpsTow != null &&
                      (gpsTow - _currentGpsTow!).abs() >= 0.999999000)) {
                //ToDo: Überprüfen im Server

                if (_currentEpochObs.isNotEmpty) {
                  _sendEpochData();
                }

                // Start new epoch
                _currentEpochObs.clear();
                _currentGpsWeek = gpsWeek;
                _currentGpsTow = gpsTow;
              }

              // Add to current epoch
              _currentEpochObs.add(signal);
            }
          }
        }
      }
    });
  }

  void _sendEpochData() {
    if (_currentEpochObs.isEmpty ||
        _currentGpsWeek == null ||
        _currentGpsTow == null) {
      return;
    }

    final obsMessage = ObsMessage(
      gpsWeek: _currentGpsWeek!,
      gpsTow: _currentGpsTow!,
      obs: _currentEpochObs,
    );

    final json = jsonEncode(obsMessage.toJson());
    print("Sending epoch: ${_currentEpochObs.length} satellites");
    print(json);
    wsService.sendMessage(json);
  }

  @override
  void stop(context) {
    // Send any remaining epoch data
    if (_currentEpochObs.isNotEmpty) {
      _sendEpochData();
    }

    _subscriptionObs?.cancel();
    _subscriptionObs = null;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Listener stopped")));
  }

  @override
  void registerHandler(IGnssTypeHandler handler) {
    _handlers.add(handler);
  }
}
