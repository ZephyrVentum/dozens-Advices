import 'package:dozens_advices/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _moralityKey = "molarityKey";
const String _politicsKey = "politicsKey";
const String _geekKey = "geekKey";
const String _miscellaneaKey = "miscellaneaKey";

Future<Configs> getConfigs() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return Configs(
      morality: sharedPreferences.getDouble(_moralityKey),
      politics: sharedPreferences.getDouble(_politicsKey),
      geek: sharedPreferences.getDouble(_geekKey),
      miscellanea: sharedPreferences.getDouble(_miscellaneaKey));
}

Future saveConfigs(Configs configs) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setDouble(_moralityKey, configs.morality);
  sharedPreferences.setDouble(_politicsKey, configs.politics);
  sharedPreferences.setDouble(_geekKey, configs.geek);
  sharedPreferences.setDouble(_miscellaneaKey, configs.miscellanea);
}
