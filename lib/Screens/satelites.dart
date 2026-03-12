// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gnsslogger/Widget/app_layout.dart';
import 'package:gnsslogger/service/gnssService/I_gnss_service.dart';
import 'package:gnsslogger/service/gnssService/typeHandler/gps_type_handler.dart';
import 'package:permission_handler/permission_handler.dart';

class Satelites extends StatefulWidget {
  @override
  State<Satelites> createState() => _SatelitesState();
}

class _SatelitesState extends State<Satelites> {
  var _hasPermissions = false;
  final IGnssService _gnssService =
      GetIt.I<IGnssService>(); //it is able to check if canHandle

  @override
  void initState() {
    super.initState();

    _gnssService.registerHandler(GpsTypeHandler());

    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final whenInUse = await Permission.locationWhenInUse.request();
    if (whenInUse.isGranted) {
      final always = await Permission.locationAlways.request();

      setState(() {
        _hasPermissions = always.isGranted;
      });
    }
  }

  @override
  Widget build(BuildContext context) => _hasPermissions
      ? AppLayout(
          title: "Logger für Rohe GNSS Daten",
          child: Container(
            decoration: BoxDecoration(color: Colors.black),
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Start Positionierungsdienst mit Hilfe von RTK",
                    style: TextStyle(color: Colors.white, fontSize: 36),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _gnssService.start(context),
                  child: Text(
                    "Start listening service",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _gnssService.stop(context),
                  child: Text(
                    "Stop listening service",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        )
      : _loadingSpinner();

  Widget _loadingSpinner() => const Center(child: CircularProgressIndicator());
}
