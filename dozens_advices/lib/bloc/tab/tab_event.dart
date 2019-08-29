import 'package:dozens_advices/bloc/bloc.dart';
import 'package:dozens_advices/data/database/advice.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TabEvent {}

class SelectPositionEvent extends TabEvent {
  final Tabs tab;

  SelectPositionEvent(this.tab);
}
