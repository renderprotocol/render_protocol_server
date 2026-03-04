import 'package:get_it/get_it.dart';
import 'package:render_protocol_server/core/config/rp_config.dart';
import 'package:render_protocol_server/core/db/rp_database.dart';
import 'package:render_protocol_server/core/db/rp_mongo_database.dart';
import 'package:render_protocol_server/repositories/render_tree_repository.dart';
import 'package:render_protocol_server/repositories/session_repository.dart';
import 'package:render_protocol_server/services/rp_handshake_service.dart';
import 'package:render_protocol_server/services/rp_render_service.dart';
import 'package:render_protocol_server/transport/grpc/grpc_transport.dart';
import 'package:render_protocol_server/transport/shelf/shelf_transport.dart';

class RenderProtocol {
  GrpcServer? _grpcServer;
  ShelfServer? _shelfServer;

  Future<void> start() async {
    final config = RPConfig.rpDefault;

    await _configureDependencies(config: config);

    final services = [RPHandshakeService(), RPRenderService()];

    final grpcTransport = GrpcTransport(
      endpoint: config.grpcEndpoint,
      services: services,
    );
    final shelfTransport = ShelfTransport(endpoint: config.shelfEndpoint);

    _grpcServer ??= await grpcTransport.makeServer();
    _shelfServer ??= await shelfTransport.makeServer();
  }

  Future<void> stop() async {
    await _grpcServer?.shutdown();
    _grpcServer = null;

    await _shelfServer?.close();
    _shelfServer = null;

    await GetIt.instance.reset(dispose: true);
  }

  Future<void> _configureDependencies({required RPConfig config}) async {
    final db = RPMongoDatabase(url: config.dbURL);
    await db.connect();

    final sessionRepo = SessionRepository(db: db);
    final renderTreeRepo = RenderTreeRepository(db: db);

    Future<void> disposeDB(RPDatabase db) async => await db.disconnect();

    GetIt.instance.registerSingleton(db, dispose: disposeDB);
    GetIt.instance.registerSingleton(sessionRepo);
    GetIt.instance.registerSingleton(renderTreeRepo);
  }
}
