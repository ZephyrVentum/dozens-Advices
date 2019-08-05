import 'package:dozens_advices/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryBloc _historyBloc;

  @override
  void initState() {
    _historyBloc = BlocProvider.of<HistoryBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _historyBloc,
        builder: (context, HistoryState state) {
          switch (state.runtimeType) {
            default:
              return Container();
          }
        });
  }
}
