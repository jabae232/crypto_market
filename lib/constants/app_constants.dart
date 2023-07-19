import 'package:intl/intl.dart';

class AppConstants {
  static const asc = 2;
  static const desc = 3;
  static const defaultList = 1;
  static final upToDate = DateFormat('yyyy-MM-dd').format(
    DateTime.now().subtract(
      const Duration(days: 2),
    ),
  );
  static final dateBefore = DateFormat('yyyy-MM-dd').format(
    DateTime.now().subtract(
      const Duration(days: 3),
    ),
  );
}
