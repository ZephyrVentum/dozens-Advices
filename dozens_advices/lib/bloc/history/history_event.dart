import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/resources/menu.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HistoryEvent {}

class LoadAdvicesEvent extends HistoryEvent {}

class SortAdvicesEvent extends HistoryEvent {
  final SortType type;

  SortAdvicesEvent(this.type);
}

class FilterByTypeEvent extends HistoryEvent {
  final String type;

  FilterByTypeEvent(this.type);
}
