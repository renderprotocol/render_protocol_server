import 'dart:io';
import 'package:grpc/grpc.dart' as grpc;
import 'package:render_protocol_server/core/rp_typedefs.dart';
import 'package:render_protocol_server/mocks/rp_render_service_mock.dart';
import 'package:render_protocol_server/routes/rp_routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_essentials/shelf_essentials.dart';

class RenderProtocol {
  ShelfServer? _shelfServer;
  GrpcServer? _grpcServer;

  Future<void> makeServers() async {
    _shelfServer = await _makeShelfServer();
    _grpcServer = await _makeGRPCServer();
  }

  Future<void> stopServers() async {
    await _shelfServer?.close();
    _shelfServer = null;

    await _grpcServer?.shutdown();
    _grpcServer = null;
  }

  Future<ShelfServer> _makeShelfServer() async {
    final ip = InternetAddress.anyIPv4;
    final port = int.parse(Platform.environment['PORT'] ?? '8080');

    final router = RPRoutes().buildRouter();

    final handler = Pipeline()
        .addMiddleware(corsHeaders())
        .addMiddleware(logRequests())
        .addHandler(router.call);

    final server = await serve(handler, ip, port);
    print('----->>> RP: Shelf server listening on port ${server.port}...');
    return server;
  }

  Future<GrpcServer> _makeGRPCServer() async {
    final codecRegistry = grpc.CodecRegistry(
      codecs: [
        grpc.GzipCodec(),
        grpc.IdentityCodec(),
      ],
    );

    final server = GrpcServer.create(
      services: [RPRenderServiceMock()],
      codecRegistry: codecRegistry,
    );

    await server.serve(port: 50051);
    print('----->>> RP: GRPC server listening on port ${server.port}...');
    return server;
  }
}
