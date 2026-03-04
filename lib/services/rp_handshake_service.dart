import 'package:grpc/grpc.dart';
import 'package:render_protocol_server/repositories/session_repository.dart';
import 'package:rp_generated_dart/rp_generated_dart.dart';

class RPHandshakeService extends RPHandshakeServiceBase {
  RPHandshakeService({required this.sessionRepo});

  final SessionRepository sessionRepo;

  @override
  Future<RPInitiateResponse> rPInitiate(
    ServiceCall call,
    RPInitiateRequest request,
  ) async {
    // TODO: implement rPInitiate
    throw UnimplementedError();
  }

  @override
  Future<RPEndSessionResponse> rPEndSession(
    ServiceCall call,
    RPEndSessionRequest request,
  ) async {
    // TODO: implement rPEndSession
    throw UnimplementedError();
  }

  @override
  Future<RPRefreshSessionResponse> rPRefreshSession(
    ServiceCall call,
    RPRefreshSessionRequest request,
  ) async {
    // TODO: implement rPRefreshSession
    throw UnimplementedError();
  }
}
