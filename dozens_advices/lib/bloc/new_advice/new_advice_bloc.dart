import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/data/repository.dart';

import '../bloc.dart';

class NewAdviceBloc extends Bloc<NewAdviceEvent, NewAdviceState> {
  Repository repository = Repository.getInstance();

  @override
  NewAdviceState get initialState => InitialNewAdviceState();

  @override
  Stream<NewAdviceState> mapEventToState(
    NewAdviceEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoadNewEvent:
        yield* _mapLoadNewAdviceToState();
        break;
      case MarkAsFavouriteEvent:
        break;
    }
  }

  Stream<NewAdviceState> _mapLoadNewAdviceToState() async* {
    yield LoadingNewAdviceState();
    Result<Advice> result = await repository.getRandomAdvice();
    if (result is SuccessResult) {
      yield LoadedAdviceState((result as SuccessResult).data);
    } else if (result is ErrorResult) {
      yield NotLoadedAdviceState((result as ErrorResult).error);
    }
  }
}
