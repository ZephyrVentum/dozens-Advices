import 'package:meta/meta.dart';

@immutable
abstract class ConfigureState {}

class InitialConfigureState extends ConfigureState {
  final Configs configs;

  InitialConfigureState(this.configs);
}

class Configs {
  double morality;
  double politics;
  double geek;

  Configs({double morality, double politics, double geek}) {
    this.morality = morality ?? 0.5;
    this.politics = politics ?? 0.5;
    this.geek = geek ?? 0.5;
  }
}
