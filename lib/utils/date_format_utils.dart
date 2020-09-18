

import 'package:intl/intl.dart';

class DateFormatUtils {

  static String simpleDateFormat(DateTime time) {
    final formatDate = DateFormat.yMMMEd('id_ID');
    return formatDate.format(time);
  } 
}