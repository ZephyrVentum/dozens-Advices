import 'package:meta/meta.dart';

@immutable
abstract class ConfigureState {}

class InitialConfigureState extends ConfigureState {
  final Configs configs;

  InitialConfigureState(this.configs);
}

class Configs {
  double molarity;
  double politics;
  double geek;

  Configs({this.molarity = 0.5, this.politics  = 0.5, this.geek  = 0.5});
}
