import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as init;
final currencyFormatProvider =
    Provider.autoDispose.family<String, double>((ref, amount) {
 
  init.NumberFormat currencyFormat = init.NumberFormat.currency(
    customPattern: "\$ #.##",
   
 
  );
  // if(amount.toInt()-amount==0){
  //   currencyFormat=NumberFormat.currency(customPattern: "${currentUser.currency} #", );
  // }
  String formattedNumber = currencyFormat.format(amount);
  if (formattedNumber.endsWith(".00")) {
    formattedNumber = formattedNumber.substring(0, formattedNumber.length - 3);
  }
  return formattedNumber;
});