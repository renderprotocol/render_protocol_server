import 'package:get_it/get_it.dart';
import 'package:render_protocol_server/mocks/mock_ui_builder.dart';
import 'package:render_protocol_server/repositories/models/render_tree_document.dart';
import 'package:render_protocol_server/repositories/render_tree_repository.dart';
import 'package:render_protocol_server/transport/shelf/extensions/router_extension.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_essentials/shelf_essentials.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:uuid/uuid.dart';

class RPAPIV1Routes extends RouterModifier {
  RPAPIV1Routes({required super.prefix});

  @override
  Router modify(Router incoming) {
    final indexPath = "$prefix/v1";
    final echoPath = "$indexPath/echo/<message>";
    final mockUIPath = "$indexPath/mock-ui";

    return incoming
      ..get(indexPath, _rootHandler)
      ..get(echoPath, _echoHandler)
      ..post(mockUIPath, _mockUIHandler);
  }

  Response _rootHandler(Request req) {
    return Response.ok('Render Protocol API v1!\n');
  }

  Response _echoHandler(Request request) {
    final message = request.params['message'];
    return Response.ok('$message\n');
  }

  Future<Response> _mockUIHandler(Request request) async {
    final body = await request.json();
    final id = body['id'];

    if (id == null) {
      return Response(400, body: 'Missing "id" field in JSON body\n');
    }

    final repo = GetIt.instance<RenderTreeRepository>();

    final doc = RenderTreeDocument(
      id: id,
      tree: MockUIBuilder.listOfCards(),
      version: Uuid().v4().toString(),
      createdAt: .now(),
      updatedAt: .now(),
    );

    await repo.write(doc);

    return Response.ok('Mock UI document with id "$id" created successfully\n');
  }
}
