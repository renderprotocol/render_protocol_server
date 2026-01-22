import 'package:render_protocol_server/extensions/ui_component_extension.dart';
import 'package:rp_generated_dart/rp_generated_dart.dart';
import 'package:uuid/uuid.dart';
import 'package:grpc/grpc.dart' as grpc;

class RPRenderServiceMock extends RPRenderServiceBase {
  final _uuid = Uuid();

  @override
  Future<RPFetchViewResponse> rPFetchView(
    grpc.ServiceCall call,
    RPFetchViewRequest request,
  ) async {
    final text = RPText();
    text.value = "Hello world from RP!";

    final image = RPImage();
    image.url = "https://picsum.photos/300/200";

    final column = RPColumn();
    column.children.add(text.makeWidget());
    column.children.add(image.makeWidget());

    final response = RPFetchViewResponse();
    response.id = _uuid.v1();
    response.view = column.makeWidget();
    return response;
  }
}
