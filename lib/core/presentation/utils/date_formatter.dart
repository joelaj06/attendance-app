import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatter {
  final _formatter = DateFormat('dd-MM-yyyy');
  final _formatterB = DateFormat('yyyy-MM-dd');
  final _dateFormatterMonthYear = DateFormat('MM-yyyy');
  final _timeFormatterA = DateFormat('hh:mm:ss a');
  final _timeFormatterB = DateFormat('kk:mm');
  final _timeFormatterC = DateFormat('kk:mm');
  final _dateFormatterADay = DateFormat('EE');
  final _dateFormatterADate = DateFormat('dd');
  final _dateFormatterMonth = DateFormat('MMMM');
  final _dateFormatterYear = DateFormat('yyyy');
  final _toStringFormatter = DateFormat('dd, MMMM yyyy');
  final _toStringFormatterB = DateFormat('EEEE, MMMM dd');
  final _toStringFormatterC = DateFormat('EEEE, MMMM dd');

  String formatDurationHM(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitHours = twoDigits(duration.inHours);
    if(twoDigitHours == '00'){
      return "${twoDigitMinutes}min";
    }else{
      return "${twoDigitHours}hr ${twoDigitMinutes}min";
    }

  }

  String toStringFormattedDate(DateTime date) {
    return _toStringFormatter.format(date);
  }

  String toStringFormattedDateB(DateTime date) {
    return _toStringFormatterB.format(date);
  }

  String dateFormatterMonth(DateTime date) {
    return _dateFormatterMonth.format(date);
  }

  String dateFormatterMonthYear(DateTime date) {
    return _dateFormatterMonthYear.format(date);
  }

  String dateFormatterYear(DateTime date) {
    return _dateFormatterYear.format(date);
  }

  String dateFormatterADay(DateTime date) {
    return _dateFormatterADay.format(date);
  }

  String dateFormatterADate(DateTime date) {
    return _dateFormatterADate.format(date);
  }

  String formattedTimeA(DateTime time) {
    return _timeFormatterA.format(time);
  }

  String formattedTimeB(DateTime time) {
    return _timeFormatterB.format(time);
  }

  String formattedTimeC(DateTime date) {
    return _timeFormatterC.format(date);
  }

  String formattedDate(DateTime date) {
    return _formatter.format(date);
  }
  String formattedDateB(DateTime date) {
    return _formatterB.format(date);
  }

  TimeOfDay timeParser(DateTime time) {
    return TimeOfDay.fromDateTime(DateTime.parse('$time'));
  }


}
