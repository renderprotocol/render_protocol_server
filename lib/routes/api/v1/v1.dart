import 'package:render_protocol_server/extensions/router_extension.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class RPAPIV1Routes extends RouterModifier {
  RPAPIV1Routes({required super.prefix});

  @override
  Router modify(Router incoming) {
    final basePath = "$prefix/v1";
    final indexPath = "$basePath/";
    final echoPath = "$basePath/echo/<message>";

    return incoming
      ..get(indexPath, _rootHandler)
      ..get(echoPath, _echoHandler);
  }

  Response _rootHandler(Request req) {
    return Response.ok('Hello, World!\n');
  }

  Response _echoHandler(Request request) {
    final message = request.params['message'];
    return Response.ok('$message\n');
  }
}
