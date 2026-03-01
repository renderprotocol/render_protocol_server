import 'package:render_protocol_server/transport/grpc/grpc_transport.dart';
import 'package:render_protocol_server/transport/shelf/shelf_transport.dart';

class RenderProtocol {
  GrpcServer? _grpcServer;
  ShelfServer? _shelfServer;

  Future<void> start() async {
    final grpcTransport = GrpcTransport();
    final shelfTransport = ShelfTransport();

    _grpcServer ??= await grpcTransport.makeServer();
    _shelfServer ??= await shelfTransport.makeServer();
  }

  Future<void> stop() async {
    await _grpcServer?.shutdown();
    _grpcServer = null;

    await _shelfServer?.close();
    _shelfServer = null;
  }
}
