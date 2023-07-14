
import 'package:flutter/material.dart';

class CryptoDetailedViewModel extends ChangeNotifier {
  SortTypes _currentSortType = SortTypes.sortWeek;

  SortTypes get currentSortType => _currentSortType;

  set currentSortType(SortTypes value) {
    _currentSortType = value;
    notifyListeners();
  }

}
// типы сортов
enum SortTypes {
  sortWeek,
  sortMonth,
  sort3Month,
  sort5Days,
  sortPercentDown,
  sortDay,
}