import 'package:render_protocol_server/extensions/router_extension.dart';
import 'package:render_protocol_server/routes/admin/admin_routes.dart';
import 'package:render_protocol_server/routes/api/api_routes.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

class RPRoutes {
  final _apiRoutes = RPAPIRoutes(prefix: "");
  final _adminRoutes = RPAdminRoutes(prefix: "");

  final _publicPath = "/public";
  final _publicHandler = createStaticHandler(
    "public",
    listDirectories: true,
    useHeaderBytesForContentType: true,
  );

  Router buildRouter() {
    return Router()
      ..apply(modifier: _apiRoutes)
      ..apply(modifier: _adminRoutes)
      ..mount(_publicPath, _publicHandler);
  }
}
