import 'dart:io';
import 'package:cron/cron.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

import '../gpsPositionLogger/I_position_storage.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> getFile(String filename) async {
  final path = await _localPath;
  final dataDir = Directory("$path/Bachelor");

  if (!await dataDir.exists()) {
    await dataDir.create(recursive: true);
  }

  final file = File('${dataDir.path}/$filename');
  if (!await file.exists()) {
    await file.create(recursive: true);
  }

  return file;
}
