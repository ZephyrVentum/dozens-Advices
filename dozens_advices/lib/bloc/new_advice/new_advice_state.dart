import 'package:dozens_advices/data/database/advice.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewAdviceState {}

class InitialNewAdviceState extends NewAdviceState {}

class LoadingNewAdviceState extends NewAdviceState {}

class LoadedAdviceState extends NewAdviceState {
  final Advice advice;

  LoadedAdviceState(this.advice);
}

class NotLoadedAdviceState extends NewAdviceState {
  final dynamic error;

  NotLoadedAdviceState(this.error);
}
