import 'package:hive_flutter/adapters.dart';

extension AppHiveAdapterExtension<T> on TypeAdapter<T> {
  void register() {
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(this);
    }
  }
}
