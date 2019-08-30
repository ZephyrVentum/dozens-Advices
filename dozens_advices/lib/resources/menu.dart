import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/resources/strings.dart';

class Menus {
  static final List<SortMenuItem> sortMenu = List<SortMenuItem>()
    ..add(SortMenuItem(SortType.MostRecent, Strings.sortMostRecentHistory))
    ..add(SortMenuItem(SortType.TheOldest, Strings.sortTheOldestHistory))
    ..add(SortMenuItem(SortType.MostPopular, Strings.sortMostPopularHistory))
    ..add(SortMenuItem(SortType.MostUnpopular, Strings.sortMostUnpopularHistory));

  static final List<FilterMenuItem> filterMenu = List<FilterMenuItem>()
    ..add(FilterMenuItem(Strings.filterAllHistory, null))
    ..add(FilterMenuItem(Strings.filterOnlyAdvicesHistory, AdviceType.ADVICE))
    ..add(FilterMenuItem(Strings.filterOnlyJokesHistory, AdviceType.JOKE))
    ..add(FilterMenuItem(Strings.filterOnlyQuotesHistory, AdviceType.QUOTE))
    ..add(FilterMenuItem(Strings.filterOnlyFactsHistory, AdviceType.FACT));
}

class SortMenuItem extends MenuItem {
  final SortType sortType;

  SortMenuItem(this.sortType, String title) : super(title);
}

class FilterMenuItem extends MenuItem {
  final String adviceType;

  FilterMenuItem(String title, this.adviceType) : super(title);
}

class MenuItem {
  final String title;

  MenuItem(this.title);
}

enum SortType { MostRecent, TheOldest, MostPopular, MostUnpopular }
