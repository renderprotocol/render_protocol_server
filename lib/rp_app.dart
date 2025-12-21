import 'dart:io';

import 'package:render_protocol_server/middlewares/rp_cors_headers.dart';
import 'package:render_protocol_server/routes/rp_routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

class RenderProtocol {
  HttpServer? _httpServer;

  Future<HttpServer> makeServer() async {
    final ip = InternetAddress.anyIPv4;
    final router = RPRoutes().buildRouter();
    final port = int.parse(Platform.environment['PORT'] ?? '8080');

    final handler = Pipeline()
        .addMiddleware(RPCorsHeaders.makeMiddleware())
        .addMiddleware(logRequests())
        .addHandler(router.call);

    final server = await serve(handler, ip, port);
    _httpServer = server;
    return server;
  }

  Future<void> stopServer() async {
    await _httpServer?.close();
    _httpServer = null;
  }
}
