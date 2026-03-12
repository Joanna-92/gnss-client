import 'package:geolocator/geolocator.dart';

abstract class PositionProvider {
  Future<Position> getPosition();
}
