import 'package:meta/meta.dart';

@immutable
abstract class NewAdviceEvent {}

class MarkAsFavouriteEvent extends NewAdviceEvent {}

class LoadNewEvent extends NewAdviceEvent {}
