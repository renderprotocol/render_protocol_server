import 'package:grpc/grpc.dart';
import 'package:render_protocol_server/repositories/render_tree_repository.dart';
import 'package:rp_generated_dart/rp_generated_dart.dart';

class RPRenderService extends RPRenderServiceBase {
  RPRenderService({required this.renderTreeRepo});

  final RenderTreeRepository renderTreeRepo;

  @override
  Future<RPFetchRenderTreeResponse> rPFetchRenderTree(
    ServiceCall call,
    RPFetchRenderTreeRequest request,
  ) async {
    // TODO: implement rPFetchRenderTree
    throw UnimplementedError();
  }

  @override
  Future<RPFetchComponentResponse> rPFetchComponent(
    ServiceCall call,
    RPFetchComponentRequest request,
  ) async {
    // TODO: implement rPFetchComponent
    throw UnimplementedError();
  }

  @override
  Stream<RPSubscribeRenderTreeResponse> rPSubscribeRenderTree(
    ServiceCall call,
    RPSubscribeRenderTreeRequest request,
  ) async* {
    // TODO: implement rPSubscribeRenderTree
    throw UnimplementedError();
  }
}
