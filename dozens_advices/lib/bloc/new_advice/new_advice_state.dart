import 'package:meta/meta.dart';

@immutable
abstract class NewAdviceState {}

class InitialNewAdviceState extends NewAdviceState {
}

class LoadingNewAdviceState extends NewAdviceState {
}

class 