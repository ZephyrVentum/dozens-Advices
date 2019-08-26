import 'package:dozens_advices/data/database/advice.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TabEvent {}

class SelectPositionEvent extends TabEvent {
  final int position;

  SelectPositionEvent(this.position);
}

class ShowAdviceDetailsEvent extends TabEvent {
  final Advice advice;

  ShowAdviceDetailsEvent(this.advice);
}
