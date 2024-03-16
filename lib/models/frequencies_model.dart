class Frequency {
  static const String day = 'day';
  static const String day_ = 'يوم';
  static const String week = 'week';
  static const String week_ = 'اسبوع';
  static const String month = 'month';
  static const String month_ = 'شهر';
  static const String year = 'year';
  static const String year_ = 'سنة';

  static const list = <String>[day, week, month, year];
  static const list_ = <String>[day_, week_, month_, year_];

  static String times(int numnum) {
    switch (numnum) {
      case 1:
        return "مرة واحدة";
      case 2:
        return "مرتين";
      case 3:
        return "ثلاث مرات";
      case 4:
        return "اربعة مرات";
      case 5:
        return "خمسة مرات";
      case 6:
        return "ستة مرات";
      case 7:
        return "سبعة مرات";
      case 8:
        return "ثمانية مرات";
      case 9:
        return "تسعة مرات";
      case 10:
        return "عشر مرات";
      default:
        return '';
    }
  }

  static String durations(String dwmy, int numnum) {
    switch (dwmy) {
      case day:
        switch (numnum) {
          case 1:
            return day_;
          case 2:
            return "يومين";
          default:
            return '$numnum ايام';
        }
      case week:
        switch (numnum) {
          case 1:
            return week_;
          case 2:
            return "اسبوعين";
          default:
            return '$numnum اسابيع';
        }
      case month:
        switch (numnum) {
          case 1:
            return month_;
          case 2:
            return "شهرين";
          default:
            return '$numnum اشهر';
        }
      case year:
        switch (numnum) {
          case 1:
            return year_;
          case 2:
            return "سنتين";
          default:
            return '$numnum سنوات';
        }
      default:
        return "$numnum $dwmy";
    }
  }
}
