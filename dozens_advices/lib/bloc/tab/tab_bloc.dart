import 'dart:async';

import 'package:bloc/bloc.dart';

import '../bloc.dart';

class TabBloc extends Bloc<TabEvent, TabState> {

  @override
  TabState get initialState => SelectedTabState(Tabs.NewAdvice);

  @override
  Stream<TabState> mapEventToState(TabEvent event,) async* {
    if (event is SelectPositionEvent) {
      yield* _mapSelectPositionTabEvent(event.tab);
    }
  }

  Stream<SelectedTabState> _mapSelectPositionTabEvent(Tabs tab) async* {
    yield SelectedTabState(tab);
  }
}

enum Tabs { NewAdvice, Configurations, History, Favourites }


