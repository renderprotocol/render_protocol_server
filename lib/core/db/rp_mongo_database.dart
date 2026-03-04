import 'package:mongo_dart/mongo_dart.dart';
import 'package:render_protocol_server/core/db/rp_database.dart';
import 'package:render_protocol_server/core/rp_logger.dart';

class RPMongoDatabase implements RPDatabase {
  RPMongoDatabase({required this.url}) : _db = Db(url);

  final String url;
  final Db _db;

  @override
  Future<void> connect() async {
    await _db.open();
    RPLogger.info("Connected to database at $url...");
  }

  @override
  Future<void> disconnect() async {
    await _db.close();
  }
}
