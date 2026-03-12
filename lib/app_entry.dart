import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:gnsslogger/Widget/app_layout.dart';
import 'package:gnsslogger/gpsPositionLogger/I_position_storage.dart';

class _AppEntry extends State<AppEntry> {
  final IPositionStorage storage = GetIt.I<IPositionStorage>();

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "GPS Koordinaten Speichern",
            style: TextStyle(color: Colors.white, fontSize: 36),
          ),
          SizedBox(height: 40),
          OutlinedButton(
            onPressed: storage.startTimer,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
            ),
            child: Text(
              "Speichere in CSV Format",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class AppEntry extends StatefulWidget {
  AppEntry({super.key});

  @override
  State<AppEntry> createState() {
    return _AppEntry();
  }
}
