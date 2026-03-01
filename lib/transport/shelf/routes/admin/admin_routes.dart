import 'package:render_protocol_server/transport/shelf/extensions/router_extension.dart';
import 'package:shelf_router/shelf_router.dart';

class RPAdminRoutes extends RouterModifier {
  RPAdminRoutes({required super.prefix});

  @override
  Router modify(Router incoming) => incoming;
}
