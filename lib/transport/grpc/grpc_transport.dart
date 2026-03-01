import 'package:grpc/grpc.dart' as grpc;
import 'package:render_protocol_server/transport/grpc/services/rp_render_service_mock.dart';
import 'package:render_protocol_server/transport/rp_server_transport.dart';

typedef GrpcServer = grpc.Server;

class GrpcTransport implements RPServerTransport {
  @override
  Future<GrpcServer> makeServer() async {
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
