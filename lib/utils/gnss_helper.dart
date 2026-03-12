// ignore_for_file: constant_identifier_names

class GnssHelper {
  static const int STATE_CODE_LOCK = 1 << 0;
  static const int STATE_BIT_SYNC = 1 << 1;
  static const int STATE_SUBFRAME_SYNC = 1 << 2;
  static const int STATE_TOW_DECODED = 1 << 3;
  static const int STATE_MSEC_AMBIGUOUS =
      1 << 4; //Ursachen: Signalreflexionen, schwache Signal, erste Lock,
  static const int STATE_SYMBOL_SYNC = 1 << 5;
  static const int STATE_GLO_STRING_SYNC = 1 << 6;
  static const int STATE_GLO_TOD_DECODED = 1 << 7;
  static const int STATE_GLO_MSEC_AMBIGUOUS = 1 << 8;
  static const int STATE_SRN_VALID = 1 << 9;
  static const int STATE_TOW_KNOWN = 1 << 10;
  static const int STATE_TOW_UNCERTAIN = 1 << 11;

  static const int ADR_STATE_VALID = 1 << 0;
  static const int ADR_STATE_RESET = 1 << 1;
  static const int ADR_STATE_CYCLE_SLIP = 1 << 2;
  static const int ADR_STATE_HALF_CYCLE_RESOLVED = 1 << 3;
  static const int ADR_STATE_HALF_CYCLE_REPORTED = 1 << 4;

  /// Debug-Helfer für GNSS Measurement State
  static List<String> getGnssStateFlags(int state) {
    final flags = <String>[];

    if ((state & STATE_CODE_LOCK) != 0) flags.add('STATE_CODE_LOCK');
    if ((state & STATE_BIT_SYNC) != 0) flags.add('STATE_BIT_SYNC');
    if ((state & STATE_SUBFRAME_SYNC) != 0) flags.add('STATE_SUBFRAME_SYNC');
    if ((state & STATE_TOW_DECODED) != 0) flags.add('STATE_TOW_DECODED');
    if ((state & STATE_MSEC_AMBIGUOUS) != 0) flags.add('STATE_MSEC_AMBIGUOUS');
    if ((state & STATE_SYMBOL_SYNC) != 0) flags.add('STATE_SYMBOL_SYNC');
    if ((state & STATE_GLO_STRING_SYNC) != 0)
      flags.add('STATE_GLO_STRING_SYNC');
    if ((state & STATE_GLO_TOD_DECODED) != 0)
      flags.add('STATE_GLO_TOD_DECODED');
    if ((state & STATE_GLO_MSEC_AMBIGUOUS) != 0)
      flags.add('STATE_GLO_MSEC_AMBIGUOUS');
    if ((state & STATE_SRN_VALID) != 0) flags.add('STATE_SRN_VALID');
    if ((state & STATE_TOW_KNOWN) != 0) flags.add('STATE_TOW_KNOWN');
    if ((state & STATE_TOW_UNCERTAIN) != 0) flags.add('STATE_TOW_UNCERTAIN');

    print(
      'GNSS State Gesetzte Flags:  ($state):\n${flags.map((f) => '   $f').join('\n')}',
    );
    return flags;
  }

  void printAdrStateFlags(int state) {
    final flags = <String>[];

    if ((state & ADR_STATE_VALID) != 0) {
      flags.add('ADR_STATE_VALID');
    }
    if ((state & ADR_STATE_RESET) != 0) {
      flags.add('ADR_STATE_RESET');
    }
    if ((state & ADR_STATE_CYCLE_SLIP) != 0) {
      flags.add('ADR_STATE_CYCLE_SLIP');
    }

    if ((state & ADR_STATE_HALF_CYCLE_RESOLVED) != 0) {
      flags.add('HALF_CYCLE_RESOLVED');
    }
    if ((state & ADR_STATE_HALF_CYCLE_REPORTED) != 0) {
      flags.add('HALF_CYCLE__REPORTED');
    }
    print(flags.toString());
  }
}
