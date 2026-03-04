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
    // Cache check: if the client already has this version, return not_modified.
    if (request.hasCachedVersion()) {
      final currentVersion = await renderTreeRepo.readVersion(request.id);
      if (currentVersion != null && currentVersion == request.cachedVersion) {
        final status = RPStatus()
          ..code = RPStatusCode.RP_STATUS_CODE_OK
          ..message = 'Render tree is up to date.';

        return RPFetchRenderTreeResponse()
          ..status = status
          ..id = request.id
          ..notModified = true
          ..version = currentVersion;
      }
    }

    // Full read.
    final doc = await renderTreeRepo.read(request.id);

    if (doc == null) {
      final status = RPStatus()
        ..code = .RP_STATUS_CODE_NOT_FOUND
        ..message = "No render tree found with id ${request.id}.";

      return RPFetchRenderTreeResponse()..status = status;
    }

    final status = RPStatus()
      ..code = .RP_STATUS_CODE_OK
      ..message = "Render tree fetched successfully.";

    return RPFetchRenderTreeResponse()
      ..status = status
      ..id = doc.id
      ..tree = doc.tree
      ..version = doc.version;
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
