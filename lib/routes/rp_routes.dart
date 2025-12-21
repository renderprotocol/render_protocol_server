import 'package:render_protocol_server/extensions/router_extension.dart';
import 'package:render_protocol_server/routes/api/api.dart';
import 'package:shelf_router/shelf_router.dart';

class RPRoutes {
  Router buildRouter() {
    final apiModifier = RPAPIRoutes(prefix: "");

    final router = Router().apply(modifier: apiModifier);

    return router;
  }
}
