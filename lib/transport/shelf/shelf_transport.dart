import 'dart:io';
import 'package:render_protocol_server/core/config/rp_config.dart';
import 'package:render_protocol_server/core/rp_logger.dart';
import 'package:render_protocol_server/transport/shelf/routes/rp_routes.dart';
import 'package:render_protocol_server/transport/rp_server_transport.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_essentials/shelf_essentials.dart';

typedef ShelfServer = HttpServer;

class ShelfTransport implements RPServerTransport<ShelfServer> {
  const ShelfTransport({required this.endpoint});

  final RPEndpoint endpoint;

  @override
  Future<ShelfServer> makeServer() async {
    final router = RPRoutes().buildRouter();

    final handler = Pipeline()
        .addMiddleware(corsHeaders())
        .addMiddleware(logRequests())
        .addHandler(router.call);

    final server = await serve(handler, endpoint.ip, endpoint.port);
    RPLogger.info("Shelf server listening on port ${server.port}...");
    return server;
  }
}
