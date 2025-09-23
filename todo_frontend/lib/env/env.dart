import 'package:dotenv/dotenv.dart';

final env = DotEnv(includePlatformEnvironment: true)..load();

abstract class Env {
  static const String localHost = 'LOCAL_HOST';
}
