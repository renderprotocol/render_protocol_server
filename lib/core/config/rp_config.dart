import 'dart:io';

class RPConfig {
  const RPConfig({
    required this.dbEndpoint,
    required this.grpcEndpoint,
    required this.shelfEndpoint,
  });

  final RPEndpoint dbEndpoint;
  final RPEndpoint grpcEndpoint;
  final RPEndpoint shelfEndpoint;

  static final _anyIPv4 = InternetAddress.anyIPv4;
  static final _localhost = InternetAddress.loopbackIPv4;

  static RPConfig fromEnvironment() {
    final dbPort = Platform.environment['DB_PORT'];
    final grpcPort = Platform.environment['GRPC_PORT'];
    final shelfPort = Platform.environment['SHELF_PORT'];

    if (dbPort != null && grpcPort != null && shelfPort != null) {
      return RPConfig(
        dbEndpoint: RPEndpoint(ip: _localhost, port: int.parse(dbPort)),
        grpcEndpoint: RPEndpoint(ip: _anyIPv4, port: int.parse(grpcPort)),
        shelfEndpoint: RPEndpoint(ip: _anyIPv4, port: int.parse(shelfPort)),
      );
    }

    return .rpDefault;
  }

  static RPConfig get rpDefault {
    final dbEndpoint = RPEndpoint(ip: _localhost, port: 27017);
    final grpcEndpoint = RPEndpoint(ip: _anyIPv4, port: 50051);
    final shelfEndpoint = RPEndpoint(ip: _anyIPv4, port: 8080);

    return RPConfig(
      dbEndpoint: dbEndpoint,
      grpcEndpoint: grpcEndpoint,
      shelfEndpoint: shelfEndpoint,
    );
  }

  String get dbURL => "mongodb://${dbEndpoint.ip.address}:${dbEndpoint.port}/renderprotocol";
}

class RPEndpoint {
  const RPEndpoint({
    required this.ip,
    required this.port,
  });

  final InternetAddress ip;
  final int port;
}
