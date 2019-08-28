import 'package:dozens_advices/data/database/advice.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewAdviceEvent {}

class MarkAsFavouriteEvent extends NewAdviceEvent {
  final Advice advice;

  MarkAsFavouriteEvent(this.advice);
}

class LoadNewEvent extends NewAdviceEvent {}

class SpeechAdviceEvent extends NewAdviceEvent {}

class ShowAdviceEvent extends NewAdviceEvent {
  final Advice advice;

  ShowAdviceEvent(this.advice);
}