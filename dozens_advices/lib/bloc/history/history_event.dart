import 'package:dozens_advices/data/database/advice.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HistoryEvent {}

class LoadAdvicesEvent extends HistoryEvent {}

class SortAdvicesEvent extends HistoryEvent {
  final int sortIndex;

  SortAdvicesEvent(this.sortIndex);
}

class FilterByTypeEvent extends HistoryEvent {
  final int filterIndex;

  FilterByTypeEvent(this.filterIndex);
}
