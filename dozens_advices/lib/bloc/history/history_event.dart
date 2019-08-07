import 'package:dozens_advices/data/database/advice.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HistoryEvent {}

class SortByDateAddedEvent extends HistoryEvent {}

class SortByDateViewedEvent extends HistoryEvent {}

class SortByMostPopularEvent extends HistoryEvent {}

class SortByMostUnpopularEvent extends HistoryEvent {}

class FilterByTypeEvent extends HistoryEvent {
  final AdviceType adviceType;

  FilterByTypeEvent(this.adviceType);
}
