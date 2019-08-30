import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dozens_advices/bloc/bloc.dart';
import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/repository.dart';
import 'package:dozens_advices/resources/menu.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  @override
  HistoryState get initialState => InitialHistoryState();

  Repository _repository = Repository.getInstance();

  List<Advice> advices;

  SortType sortType = SortType.MostRecent;
  String filterAdviceType;

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoadAdvicesEvent:
        yield* _mapLoadAdvicesToState();
        break;
      case SortAdvicesEvent:
        sortType = (event as SortAdvicesEvent).type;
        yield* _mapToSortType(sortType);
        break;
      case FilterByTypeEvent:
        yield* _mapFilterByTypeToState((event as FilterByTypeEvent));
        break;
    }
  }

  Stream<HistoryState> _mapLoadAdvicesToState() async* {
    advices = await _repository.getAdvicesHistory();
    yield* _mapToSortType(sortType);
  }

  Stream<HistoryState> _mapSortMostRecentToState() async* {
    advices.sort((a, b) => b.createdAt - a.createdAt);
    yield LoadedHistoryState(advices);
  }

  Stream<HistoryState> _mapSortTheOldestToState() async* {
    advices.sort((a, b) => a.createdAt - b.createdAt);
    yield LoadedHistoryState(advices);
  }

  Stream<HistoryState> _mapSortMostPopularToState() async* {
    advices.sort((a, b) => b.views - a.views);
    yield LoadedHistoryState(advices);
  }

  Stream<HistoryState> _mapSortMostUnpopularToState() async* {
    advices.sort((a, b) => a.views - b.views);
    yield LoadedHistoryState(advices);
  }

  Stream<HistoryState> _mapToSortType(SortType sortType) async* {
    switch (sortType) {
      case SortType.MostRecent:
        yield* _mapSortMostRecentToState();
        break;
      case SortType.TheOldest:
        yield* _mapSortTheOldestToState();
        break;
      case SortType.MostPopular:
        yield* _mapSortMostPopularToState();
        break;
      case SortType.MostUnpopular:
        yield* _mapSortMostUnpopularToState();
        break;
      default:
        yield* _mapSortMostRecentToState();
    }
  }

  Stream<HistoryState> _mapFilterByTypeToState(FilterByTypeEvent event) async* {
    filterAdviceType = event.type;
    if (filterAdviceType != null) {
      advices = await _repository.getAdvicesByType(filterAdviceType);
      yield* _mapToSortType(sortType);
    } else {
      yield* _mapLoadAdvicesToState();
    }
  }
}
