import 'package:dozens_advices/bloc/bloc.dart';
import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/resources/strings.dart';
import 'package:dozens_advices/resources/styles.dart';
import 'package:dozens_advices/screens/home_screen.dart';
import 'package:dozens_advices/widgets/advices_list.dart';
import 'package:dozens_advices/widgets/gradient_button.dart';
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
  NewAdviceBloc _newAdviceBloc;

  @override
  void initState() {
    _favouritesBloc = BlocProvider.of<FavouritesBloc>(context);
    _newAdviceBloc = BlocProvider.of<NewAdviceBloc>(context);
    _favouritesBloc.dispatch(LoadFavouriteAdvicesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            'assets/images/star_tile.png',
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width / 1.75,
          ),
        ),
        BlocBuilder(
          bloc: _favouritesBloc,
          builder: (_, state) {
            switch (state.runtimeType) {
              case InitialFavouritesState:
                return _buildInitialState();
              case LoadingFavouritesState:
                return _buildLoadingState();
              case LoadedFavouritesState:
                List<Advice> advices = (state as LoadedFavouritesState).advices;
                return advices.isNotEmpty ? _buildLoadedState(advices) : _buildEmptyState();
              default:
                return Container();
            }
          },
        )
      ],
    );
  }

  Widget _buildEmptyState() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(Strings.favouriteEmpty, textAlign: TextAlign.center, style: Styles.infoTextStyle(context)),
            const SizedBox(
              height: 8,
            ),
            RaisedGradientButton(
              onPressed: () {
                TabControlInheritedWidget.of(context).tabController.index = 0;
              },
              child: Text(Strings.fixItUpHistory, style: Styles.buttonTextStyle(context)),
              gradient: LinearGradient(colors: [Styles.startGradientColor, Styles.endGradientColor]),
            )
          ],
        ),
      );

  Widget _buildLoadedState(List<Advice> advices) => AdvicesList(advices: advices, onItemSelected: onAdviceSelected);

  Widget _buildInitialState() => _buildLoadingState();

  Widget _buildLoadingState() => Center(child: ProgressBar());

  void onAdviceSelected(Advice advice) {
    _newAdviceBloc.dispatch(ShowAdviceEvent(advice));
    TabControlInheritedWidget.of(context).tabController.index = 0;
  }
}
