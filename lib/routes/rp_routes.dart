import 'package:render_protocol_server/extensions/router_extension.dart';
import 'package:render_protocol_server/routes/api/api.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

class RPRoutes {
  final _apiModifier = RPAPIRoutes(prefix: "");

  final _publicPath = "/public";
  final _publicHandler = createStaticHandler(
    "public",
    listDirectories: true,
    useHeaderBytesForContentType: true,
  );

  Router buildRouter() {
    return Router()
      ..apply(modifier: _apiModifier)
      ..mount(_publicPath, _publicHandler);
  }
}
