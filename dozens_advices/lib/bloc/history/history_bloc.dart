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

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    switch (event.runtimeType){
      case LoadAdvicesEvent:
        yield* _mapLoadAdvicesToState();
        break;
      case SortByDateAddedEvent:
        yield* _mapSortByDateAddedToState();
        break;
    }
  }

  Stream<HistoryState> _mapLoadAdvicesToState() async* {
    yield LoadingHistoryState();
    advices = await _repository.getAdvicesHistory();
    yield LoadedHistoryState(advices);
  }

  Stream<HistoryState> _mapSortByDateAddedToState() async* {
    advices.sort((a, b) => a.createdAt - b.createdAt);
    yield LoadingHistoryState();
  }

//  Stream<HistoryState> _mapSortByDateAddedToState() async* {
//    advices.sort((a, b) => a.createdAt - b.createdAt);
//    yield LoadingHistoryState();
//  }

}
