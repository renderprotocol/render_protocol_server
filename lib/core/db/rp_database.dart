import 'package:mongo_dart/mongo_dart.dart';

abstract interface class RPDatabase {
  Future<void> connect();
  Future<void> disconnect();
  DbCollection collection(String name);
}
