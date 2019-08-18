import 'package:dozens_advices/bloc/bloc.dart';
import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/widgets/advices_list.dart';
import 'package:dozens_advices/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

DateFormat formatter = DateFormat('dd/MM/yyyy');

class FavouritesScreen extends StatefulWidget {
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  FavouritesBloc _favouritesBloc;

  @override
  void initState() {
    _favouritesBloc = BlocProvider.of<FavouritesBloc>(context);
    _favouritesBloc.dispatch(LoadFavouriteAdvicesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _favouritesBloc,
      builder: (_, state) {
        switch (state.runtimeType) {
          case InitialFavouritesState:
            return _buildInitialState();
          case LoadingFavouritesState:
            return _buildLoadingState();
          case LoadedFavouritesState:
            return _buildLoadedState((state as LoadedFavouritesState).advices);
          default:
            return Container();
        }
      },
    );
  }

  Widget _buildLoadedState(List<Advice> advices) =>
      AdvicesList(advices: advices);

  Widget _buildInitialState() => _buildLoadingState();

  Widget _buildLoadingState() => Center(child: ProgressBar());
}
