import 'dart:convert';
import 'dart:io';
import 'package:cron/cron.dart';
import 'package:get_it/get_it.dart';
import 'package:gnsslogger/gpsPositionLogger/position_provider.dart';
import 'package:gnsslogger/gpsPositionLogger/I_position_storage.dart';
import '../utils/file_helper.dart' as FileHelper;

class LocalFileSystemPositionStorage implements IPositionStorage {
  @override
  Future<void> savePosition() async {
    PositionProvider positionProvider = GetIt.I<PositionProvider>();

    try {
      final position = await positionProvider.getPosition();
      await writeDataCSV(
        position.latitude,
        position.longitude,
        position.altitude,
      );
    } catch (e) {
      print("Fehler beim Speichern: $e");
    }
  }

  @override
  Future<File> writeDataCSV(
    double latitude,
    double longitude,
    double altitude,
  ) async {
    final file = await FileHelper.getFile("gpsDatenCsv.csv");

    final timestamp = DateTime.now().toIso8601String();
    final line = "$latitude,$longitude,$altitude, $timestamp\n ";

    if (await file.length() == 0) {
      await file.writeAsString("latitude,longitude,altitude, timestamp\n");
    }

    await file.writeAsString(line, mode: FileMode.append);
    return file;
  }

  @override
  void startTimer() async {
    final IPositionStorage storage = GetIt.I<IPositionStorage>();
    while (true) {
      await Future.delayed(Duration(seconds: 15));
      storage.savePosition();
    }
  }
}
