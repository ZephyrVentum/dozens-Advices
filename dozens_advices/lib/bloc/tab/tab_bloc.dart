import 'dart:async';

import 'package:bloc/bloc.dart';

import '../bloc.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  @override
  TabState get initialState => SelectedTabState(Tabs.NewAdvice);

  @override
  Stream<TabState> mapEventToState(
    TabEvent event,
  ) async* {
    if (event is SelectPositionEvent) {
      yield* _mapSelectPositionTabEvent(event.position);
    }
  }

  Stream<SelectedTabState> _mapSelectPositionTabEvent(int position) async* {
    yield SelectedTabState(Tabs.values[position]);
  }
}

enum Tabs { NewAdvice, Configurations, History, Favourites }
