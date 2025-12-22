import 'dart:io';

import 'package:render_protocol_server/routes/rp_routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_essentials/shelf_essentials.dart';

class RenderProtocol {
  HttpServer? _httpServer;

  Future<HttpServer> makeServer() async {
    final ip = InternetAddress.anyIPv4;
    final port = int.parse(Platform.environment['PORT'] ?? '8080');

    final router = RPRoutes().buildRouter();

    final handler = Pipeline()
        .addMiddleware(corsHeaders())
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
