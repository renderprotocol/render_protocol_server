import 'package:grpc/grpc.dart' as grpc;
import 'package:render_protocol_server/core/config/rp_config.dart';
import 'package:render_protocol_server/core/rp_logger.dart';
import 'package:render_protocol_server/transport/rp_server_transport.dart';

typedef GrpcServer = grpc.Server;

class GrpcTransport implements RPServerTransport<GrpcServer> {
  const GrpcTransport({required this.endpoint, required this.services});

  final RPEndpoint endpoint;
  final List<grpc.Service> services;

  @override
  Future<GrpcServer> makeServer() async {
    final codecRegistry = grpc.CodecRegistry(
      codecs: [
        grpc.GzipCodec(),
        grpc.IdentityCodec(),
      ],
    );

    final server = GrpcServer.create(
      services: services,
      codecRegistry: codecRegistry,
    );

    await server.serve(address: endpoint.ip, port: endpoint.port);
    RPLogger.info("GRPC server listening on port ${server.port}...");
    return server;
  }
}
