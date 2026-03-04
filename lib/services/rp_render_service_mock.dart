import 'package:render_protocol_server/mocks/mock_ui_builder.dart';
import 'package:rp_generated_dart/rp_generated_dart.dart';
import 'package:uuid/uuid.dart';
import 'package:grpc/grpc.dart' as grpc;

class RPRenderServiceMock extends RPRenderServiceBase {
  final _uuid = Uuid();

  @override
  Future<RPFetchRenderTreeResponse> rPFetchRenderTree(
    grpc.ServiceCall call,
    RPFetchRenderTreeRequest request,
  ) async {
    final response = RPFetchRenderTreeResponse();
    response.id = _uuid.v1();
    response.tree = MockUIBuilder.listOfCards();

    return response;
  }

  @override
  Future<RPFetchComponentResponse> rPFetchComponent(
    grpc.ServiceCall call,
    RPFetchComponentRequest request,
  ) {
    // TODO: implement rPFetchComponent
    throw UnimplementedError();
  }

  @override
  Stream<RPSubscribeRenderTreeResponse> rPSubscribeRenderTree(
    grpc.ServiceCall call,
    RPSubscribeRenderTreeRequest request,
  ) {
    // TODO: implement rPSubscribeRenderTree
    throw UnimplementedError();
  }
}
