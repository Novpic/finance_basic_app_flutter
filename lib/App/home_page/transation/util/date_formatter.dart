
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
 
class DateFormatter {
 

  //DateTime storedDate; 
  //DateFormatter({required this.storedDate});
  

 
  static String dateFormatter (DateTime dateTime) {

    DateTime now = DateTime.now();
    Duration diference = Duration(minutes: 0);
    

    DateTime justNow = now.subtract(Duration(minutes: 1));
    DateTime minutesAgo = now.subtract(Duration(hours: 1));
    DateTime yesterday = DateTime(now.year, now.month,now.day);
    DateTime dayBeforeYesterday = DateTime(now.year, now.month,now.day-1);
    DateTime hoursAgo = now.subtract(Duration(hours: 24));
    DateTime weekAgo = now.subtract(Duration(days: 7));
    DateTime monthsAgo = now.subtract(Duration(days: 30));
    DateTime semesterAgo = now.subtract(Duration(days: 150));





    if (!dateTime.difference(justNow).isNegative) {
      return "Just now";
    }
    else if(!dateTime.difference(minutesAgo).isNegative){
      diference = dateTime.difference(minutesAgo);
      return '${60-diference.inMinutes} minutes ago';
    }
    else if(!dateTime.difference(hoursAgo).isNegative && !dateTime.difference(yesterday).isNegative){
      return DateFormat('jm').format(dateTime);
    }
    else if(!dateTime.difference(dayBeforeYesterday).isNegative){
      return 'Yesterday ${DateFormat('jm').format(dateTime)}';
    }
    else if(!dateTime.difference(weekAgo).isNegative){
      return DateFormat('EEEE d').format(dateTime);
    }
    else if(!dateTime.difference(monthsAgo).isNegative){
      return DateFormat('MMMMd').format(dateTime);
    }
    else{
      return DateFormat('yMMMMd').format(dateTime);
    }
  }

}