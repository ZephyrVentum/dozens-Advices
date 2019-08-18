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

  @override
  void initState() {
    _historyBloc = BlocProvider.of<HistoryBloc>(context);
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
      AdvicesList(advices: advices);

  Widget _buildInitialState() => _buildLoadingState();

  Widget _buildLoadingState() => Center(child: ProgressBar());
}
