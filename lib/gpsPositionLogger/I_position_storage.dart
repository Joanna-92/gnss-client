import 'dart:io';

abstract class IPositionStorage {
  Future<File> writeDataCSV(double latitude, double longitude, double altitude);
  Future<void> savePosition();
  void startTimer();
}
