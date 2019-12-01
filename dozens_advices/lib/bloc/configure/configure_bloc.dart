import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dozens_advices/data/repository.dart';

import '../bloc.dart';

class ConfigureBloc extends Bloc<ConfigureEvent, ConfigureState> {
  Repository repository = Repository.getInstance();
  Configs configs = Configs();

  @override
  ConfigureState get initialState => InitialConfigureState(Configs());

  @override
  Stream<ConfigureState> mapEventToState(
    ConfigureEvent event,
  ) async* {
    switch (event.runtimeType) {
      case MolarityConfigureEvent:
        yield* _mapUpdateConfigsToState(morality: (event as MolarityConfigureEvent).value);
        break;
      case PoliticsConfigureEvent:
        yield* _mapUpdateConfigsToState(politics: (event as PoliticsConfigureEvent).value);
        break;
      case GeekConfigureEvent:
        yield* _mapUpdateConfigsToState(geek: (event as GeekConfigureEvent).value);
        break;
      case MiscellaneaConfigureEvent:
        yield* _mapUpdateConfigsToState(miscellanea: (event as MiscellaneaConfigureEvent).value);
        break;
      case RefreshConfigureEvent:
        configs = Configs();
        repository.saveConfigs(configs);
        yield* Stream.value(InitialConfigureState(configs));
        break;
      case ShuffleConfigureEvent:
        Random random = Random();
        configs = Configs(
            morality: random.nextDouble(),
            politics: random.nextDouble(),
            geek: random.nextDouble(),
            miscellanea: random.nextDouble());
        repository.saveConfigs(configs);
        yield* Stream.value(InitialConfigureState(configs));
        break;
      case LoadStoredConfigureEvent:
        yield* _mapLoadStoredToState();
        break;
    }
  }

  Stream<ConfigureState> _mapLoadStoredToState() async* {
    configs = await repository.getConfigs();
    yield InitialConfigureState(configs ?? Configs());
  }

  Stream<ConfigureState> _mapUpdateConfigsToState(
      {double morality, double politics, double geek, double miscellanea}) async* {
    Configs tempConfigs = Configs(
        morality: configs.morality, politics: configs.politics, geek: configs.geek, miscellanea: configs.miscellanea);
    tempConfigs.morality = morality ?? configs.morality;
    tempConfigs.politics = politics ?? configs.politics;
    tempConfigs.geek = geek ?? configs.geek;
    tempConfigs.miscellanea = miscellanea ?? configs.miscellanea;
    if (tempConfigs.morality + tempConfigs.politics + tempConfigs.geek + tempConfigs.miscellanea >= 0.05) {
      configs = tempConfigs;
    }
    repository.saveConfigs(configs);
    yield InitialConfigureState(configs);
  }
}
