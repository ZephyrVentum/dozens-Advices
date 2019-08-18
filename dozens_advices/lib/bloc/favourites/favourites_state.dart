import 'package:dozens_advices/data/database/advice.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FavouritesState {}

class InitialFavouritesState extends FavouritesState {}

class LoadedFavouritesState extends FavouritesState {
  final List<Advice> advices;

  LoadedFavouritesState(this.advices);
}

class LoadingFavouritesState extends FavouritesState {}