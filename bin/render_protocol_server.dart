import 'package:render_protocol_server/rp_app.dart';

Future<void> main(List<String> args) async {
  final app = RenderProtocol();
  await app.makeServers();
}
