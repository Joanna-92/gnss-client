import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gnsslogger/Widget/app_layout.dart';
import 'package:gnsslogger/gpsPositionLogger/position_provider.dart';
import 'package:gnsslogger/service/gnssService/I_gnss_service.dart';
import 'package:gnsslogger/gpsPositionLogger/local_file_system_position_storage.dart';
import 'package:gnsslogger/gpsPositionLogger/position_logger.dart';
import 'package:gnsslogger/service/gnssService/gnss_service_impl.dart';
import 'package:gnsslogger/gpsPositionLogger/I_position_storage.dart';
import 'Screens/satelites.dart';
import 'Widget/custom_drawer.dart';
import 'app_entry.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<IPositionStorage>(LocalFileSystemPositionStorage());
  GetIt.I.registerSingleton<PositionProvider>(GeolocatorPositionProvider());
  GetIt.I.registerSingleton<IGnssService>(GnssServiceImpl());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GNSS Logger',
      routes: {
        '/SaveCoordinats': (context) => AppEntry(),
        '/Satelites': (context) => Satelites(),
      },

      home: AppEntry(),
    );
  }
}
