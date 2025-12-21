import 'package:render_protocol_server/extensions/router_extension.dart';
import 'package:render_protocol_server/routes/api/v1/v1.dart';
import 'package:shelf_router/shelf_router.dart';

class RPAPIRoutes extends RouterModifier {
  RPAPIRoutes({required super.prefix});

  @override
  Router modify(Router incoming) {
    final v1 = RPAPIV1Routes(prefix: "$prefix/api");
    return incoming.apply(modifier: v1);
  }
}
