import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {

  
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }
    String newText;
    String valueString = newValue.text.replaceAll(RegExp(r'^[\$,.]+|[\$,.]*'), '');
    double value = double.parse(valueString);
    if(value>=1){
      value =value/10;
      final formatter = NumberFormat("#,##0.0", "en_US");
      newText = formatter.format(value).toString();
    }
    else{
      newText = '0.0';
    }
    
    //final formatter = NumberFormat.currency(symbol: '\$');
    //String newText = formatter.format(value / 100);

    

    return newValue.copyWith(
        text: '\$'+newText,
        selection: TextSelection.collapsed(offset: newText.length+1)
        );
  }

  static String currencyFormater (double value){
      final formatter = NumberFormat("#,##0.0", "en_US");
      return formatter.format(value).toString();
  }
  
}
