import 'dart:async';

import 'package:bloc/bloc.dart';

import '../bloc.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
//  List<Tabs> tabs = List<Tabs>()..add(value)

  @override
  TabState get initialState => SelectedTabState(Tabs.NewAdvice);

  @override
  Stream<TabState> mapEventToState(TabEvent event,) async* {
    if (event is SelectPositionEvent) {
      yield* _mapSelectPositionTabEvent(event.position);
    }
  }

  Stream<SelectedTabState> _mapSelectPositionTabEvent(int position) async* {
    yield SelectedTabState(Tabs.values[position]);
  }
}

enum Tabs { NewAdvice, Configurations, History, Favourites }

//class Tabs {
//  Tabs(this.index);
//
//  final int index;
//}
//
//class NewAdviceTab extends Tabs {
//  NewAdviceTab(int index) : super(index);
//
//}
//
//class ConfigurationsTab extends Tabs {
//  ConfigurationsTab(int index) : super(index);
//
//}
//
//class HistoryTab extends Tabs {
//  HistoryTab(int index, this.sortIndex, this.adviceIndex) : super(index);
//
//  int sortIndex = 0;
//  int adviceIndex = 0;
//}

