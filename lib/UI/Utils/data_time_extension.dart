
import 'package:intl/intl.dart';

extension Time_Extension on DateTime 
{
  String get toformattedDate 
  {
    DateFormat formatter = DateFormat("dd/MM/yyyy");
    return formatter.format(this);
  }

  String get dayName 
  {
    List<String> days = ["Sat", "Sun", "Mon", "Tue", "Wed", "Thurs", "Fri"];
    return days[weekday - 1];
  }
}
