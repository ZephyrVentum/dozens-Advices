import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ConfigureEvent {}

class MolarityConfigureEvent extends ConfigureEvent {
  final double value;

  MolarityConfigureEvent(this.value);
}

class PoliticsConfigureEvent extends ConfigureEvent {
  final double value;

  PoliticsConfigureEvent(this.value);
}

class GeekConfigureEvent extends ConfigureEvent {
  final double value;

  GeekConfigureEvent(this.value);
}

class MiscellaneaConfigureEvent extends ConfigureEvent {
  final double value;

  MiscellaneaConfigureEvent(this.value);
}

class RefreshConfigureEvent extends ConfigureEvent {}

class ShuffleConfigureEvent extends ConfigureEvent {}

class LoadStoredConfigureEvent extends ConfigureEvent {}