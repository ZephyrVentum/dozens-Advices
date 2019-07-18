import 'dart:async';

import 'package:bloc/bloc.dart';

import '../bloc.dart';

class NewAdviceBloc extends Bloc<NewAdviceEvent, NewAdviceState> {
  @override
  NewAdviceState get initialState => InitialNewAdviceState();

  @override
  Stream<NewAdviceState> mapEventToState(
    NewAdviceEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
