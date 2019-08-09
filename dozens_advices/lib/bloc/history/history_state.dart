import 'package:dozens_advices/data/database/advice.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HistoryState {}

class InitialHistoryState extends HistoryState {}

class LoadedHistoryState extends HistoryState {
  final List<Advice> advices;

  LoadedHistoryState(this.advices);
}

class LoadingHistoryState extends HistoryState {}


