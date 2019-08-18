import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dozens_advices/data/repository.dart';
import '../bloc.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {

  Repository _repository = Repository.getInstance();

  @override
  FavouritesState get initialState => InitialFavouritesState();

  @override
  Stream<FavouritesState> mapEventToState(
    FavouritesEvent event,
  ) async* {
    switch (event.runtimeType){
      case LoadFavouriteAdvicesEvent:
        yield* _mapLoadFavouriteAdvicesToState();
    }
  }

  Stream<FavouritesState> _mapLoadFavouriteAdvicesToState() async*{
    yield LoadedFavouritesState(await _repository.getFavouriteAdvices());
  }

}
