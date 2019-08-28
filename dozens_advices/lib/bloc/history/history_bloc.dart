import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dozens_advices/bloc/bloc.dart';
import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/repository.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  @override
  HistoryState get initialState => InitialHistoryState();

  Repository _repository = Repository.getInstance();

  List<Advice> advices;

  int sortIndex = 0;
  int filterIndex = 0;

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoadAdvicesEvent:
        yield* _mapLoadAdvicesToState();
        break;
      case SortAdvicesEvent:
        sortIndex = (event as SortAdvicesEvent).sortIndex;
        yield* _mapToSortType(sortIndex);
        break;
      case FilterByTypeEvent:
        filterIndex = (event as FilterByTypeEvent).filterIndex;
        yield* _mapFilterByTypeToState();
        break;
    }
  }

  Stream<HistoryState> _mapLoadAdvicesToState() async* {
    advices = await _repository.getAdvicesHistory();
    yield* _mapToSortType(sortIndex);
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

  Stream<HistoryState> _mapToSortType(int sortIndex) async* {
    switch (sortIndex) {
      case 0:
        yield* _mapSortMostRecentToState();
        break;
      case 1:
        yield* _mapSortTheOldestToState();
        break;
      case 2:
        yield* _mapSortMostPopularToState();
        break;
      case 3:
        yield* _mapSortMostUnpopularToState();
        break;
      default:
        yield* _mapSortMostRecentToState();
    }
  }

  Stream<HistoryState> _mapFilterByTypeToState() async* {
    String adviceType;
    switch (filterIndex) {
      case 1:
        adviceType = AdviceType.ADVICE;
        break;
      case 2:
        adviceType = AdviceType.JOKE;
        break;
      case 3:
        adviceType = AdviceType.QUOTE;
        break;
      case 4:
        adviceType = AdviceType.FACT;
    }
    if (adviceType != null) {
      advices = await _repository.getAdvicesByType(adviceType);
      yield* _mapToSortType(sortIndex);
    } else {
      yield* _mapLoadAdvicesToState();
    }
  }
}
