import 'package:render_protocol_server/rp_app.dart';

Future<void> main(List<String> args) async {
  final app = RenderProtocol();
  final server = await app.makeServer();

  print('Server listening on port ${server.port}');
}
