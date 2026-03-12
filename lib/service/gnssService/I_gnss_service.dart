import 'typeHandler/I_gnss_type_handle.dart';

abstract class IGnssService {
  void registerHandler(IGnssTypeHandler handler);
  void start(context);
  void stop(context);
}
