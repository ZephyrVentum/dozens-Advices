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
      case RefreshConfigureEvent:
        configs = Configs();
        repository.saveConfigs(configs);
        yield* Stream.value(InitialConfigureState(configs));
        break;
      case ShuffleConfigureEvent:
        Random random = Random();
        configs = Configs(molarity: random.nextDouble(), politics: random.nextDouble(), geek: random.nextDouble());
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
    yield InitialConfigureState(configs);
  }

  Stream<ConfigureState> _mapUpdateConfigsToState({double morality, double politics, double geek}) async* {
    configs.molarity = morality ?? configs.molarity;
    configs.politics = politics ?? configs.politics;
    configs.geek = geek ?? configs.geek;
    repository.saveConfigs(configs);
    yield InitialConfigureState(configs);
  }
}
