import 'package:crypto_polygon/src/features/crypto_list_screen/data/dto/daily_bars_dto.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../constants/app_constants.dart';

class CryptoViewModel extends ChangeNotifier {
  DailyBars? _cryptosDateBefore;
  DailyBars? _cryptosUpToDate;
  var counterPrice = 1;
  var counterPercent = 1;
  void incrementCounterPrice() {
    counterPrice++;
    if (counterPrice > 3) {
      counterPrice = 1;
    }
    if (counterPrice == AppConstants.defaultList) {
      currentSortType = SortTypes.sortPercentDefault;
    }
    if (counterPrice == AppConstants.asc) {
      currentSortType = SortTypes.sortPriceUp;
    }
    if (counterPrice == AppConstants.desc) {
      currentSortType = SortTypes.sortPriceDown;
    }
  }

  void incrementCounterPercent() {
    counterPercent++;
    if (counterPercent > 3) {
      counterPercent = 1;
    }
    if (counterPercent == AppConstants.defaultList) {
      currentSortType = SortTypes.sortPercentDefault;
    }
    if (counterPercent == AppConstants.asc) {
      currentSortType = SortTypes.sortPercentUp;
    }
    if (counterPercent == AppConstants.desc) {
      currentSortType = SortTypes.sortPercentDown;
    }
  }

  List<Result> _sortedList = [];
  SortTypes _currentSortType = SortTypes.sortPriceDefault;
  void filterList(bool isPrice) {
    if (isPrice) {
      incrementCounterPrice();
    } else {
      incrementCounterPercent();
    }
    if (cryptosUpToDate != null) {
      sortedList.clear();
      if (currentSortType == SortTypes.sortPriceDefault ||
          currentSortType == SortTypes.sortPercentDefault) {
        sortedList.addAll(cryptosUpToDate!.results);
      }
      if (currentSortType == SortTypes.sortPriceUp) {
        sortedList.addAll(cryptosUpToDate!.results);
        sortedList.sort((a, b) => b.c.compareTo(a.c));
      }
      if (currentSortType == SortTypes.sortPriceDown) {
        sortedList.addAll(cryptosUpToDate!.results);
        sortedList.sort((a, b) => a.c.compareTo(b.c));
      }
      if (currentSortType == SortTypes.sortPercentUp) {
        sortedList.addAll(cryptosUpToDate!.results);
        sortedList.sort((a, b) => b.differ!.compareTo(a.differ!));
      }
      if (currentSortType == SortTypes.sortPercentDown) {
        sortedList.addAll(cryptosUpToDate!.results);
        sortedList.sort((a, b) => a.differ!.compareTo(b.differ!));
      }
    }
  }

  void listMatch() {
    for (int i = 0; i < cryptosUpToDate!.results.length; i++) {
      for (int j = 0; j < cryptosDateBefore!.results.length; j++) {
        if (cryptosUpToDate!.results[i].t == cryptosDateBefore!.results[j].t) {
          cryptosUpToDate!.results[i].prevPrice = cryptosDateBefore!.results[j].c;
          cryptosUpToDate!.results[i].differ =
              (cryptosUpToDate!.results[i].c - cryptosDateBefore!.results[j].c) /
                  cryptosUpToDate!.results[i].c;
        }
      }
    }
    sortedList.addAll(cryptosUpToDate!.results);
  }

  List<Result> get sortedList => _sortedList;

  set sortedList(List<Result> value) {
    _sortedList = value;
    notifyListeners();
  }

  SortTypes get currentSortType => _currentSortType;

  set currentSortType(SortTypes value) {
    _currentSortType = value;
    notifyListeners();
  }

  DailyBars? get cryptosDateBefore => _cryptosDateBefore;

  set cryptosDateBefore(DailyBars? value) {
    _cryptosDateBefore = value;
    notifyListeners();
  }

  DailyBars? get cryptosUpToDate => _cryptosUpToDate;

  set cryptosUpToDate(DailyBars? value) {
    _cryptosUpToDate = value;
    notifyListeners();
  }
}

enum SortTypes {
  sortPriceUp,
  sortPriceDown,
  sortPriceDefault,
  sortPercentDefault,
  sortPercentDown,
  sortPercentUp,
}
