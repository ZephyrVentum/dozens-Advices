import 'package:meta/meta.dart';

@immutable
abstract class FavouritesEvent {}

class LoadFavouriteAdvicesEvent extends FavouritesEvent {}