import 'package:dozens_advices/bloc/tab/tab_bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TabState {}

class SelectedTabState extends TabState {
  final Tabs selectedTab;

  SelectedTabState(this.selectedTab);
}
