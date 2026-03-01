import 'package:meta/meta.dart';
import 'package:shelf_router/shelf_router.dart';

abstract class RouterModifier {
  final String prefix;
  Router modify(Router incoming);

  const RouterModifier({required this.prefix});
}

extension RouterExtension on Router {
  @protected
  Router apply({required RouterModifier modifier}) {
    return modifier.modify(this);
  }
}
