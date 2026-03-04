import 'dart:io';
import 'package:render_protocol_server/transport/shelf/routes/rp_routes.dart';
import 'package:render_protocol_server/transport/rp_server_transport.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_essentials/shelf_essentials.dart';

typedef ShelfServer = HttpServer;

class ShelfTransport implements RPServerTransport<ShelfServer> {
  @override
  Future<ShelfServer> makeServer() async {
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
}
