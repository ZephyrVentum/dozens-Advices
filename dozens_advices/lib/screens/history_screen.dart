import 'package:dozens_advices/bloc/bloc.dart';
import 'package:dozens_advices/data/database/advice.dart';
import 'package:dozens_advices/widgets/advices_list.dart';
import 'package:dozens_advices/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

DateFormat formatter = DateFormat('dd/MM/yyyy');

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryBloc _historyBloc;
  NewAdviceBloc _newAdviceBloc;
  TabBloc _tabBloc;

  @override
  void initState() {
    _historyBloc = BlocProvider.of<HistoryBloc>(context);
    _newAdviceBloc = BlocProvider.of<NewAdviceBloc>(context);
    _tabBloc = BlocProvider.of<TabBloc>(context);
    _historyBloc.dispatch(LoadAdvicesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _historyBloc,
        builder: (context, HistoryState state) {
          switch (state.runtimeType) {
            case InitialHistoryState:
              return _buildInitialState();
            case LoadingHistoryState:
              return _buildLoadingState();
            case LoadedHistoryState:
              return _buildLoadedState((state as LoadedHistoryState).advices);
            default:
              return Container();
          }
        });
  }

  Widget _buildLoadedState(List<Advice> advices) =>
      AdvicesList(advices: advices, onItemSelected: onAdviceSelected,);

  Widget _buildInitialState() => _buildLoadingState();

  Widget _buildLoadingState() => Center(child: ProgressBar());
  
  void onAdviceSelected(Advice advice){
    _newAdviceBloc.dispatch(ShowAdviceEvent(advice));
    _tabBloc.dispatch(SelectPositionEvent(0));
  }
}
