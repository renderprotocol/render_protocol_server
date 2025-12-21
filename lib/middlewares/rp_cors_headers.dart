// ignore_for_file: constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:shelf/shelf.dart';

typedef OriginChecker = bool Function(String origin);

abstract class RPCorsHeaders {
  static const ACCESS_CONTROL_ALLOW_ORIGIN = 'Access-Control-Allow-Origin';
  static const ACCESS_CONTROL_EXPOSE_HEADERS = 'Access-Control-Expose-Headers';
  static const ACCESS_CONTROL_ALLOW_CREDENTIALS =
      'Access-Control-Allow-Credentials';
  static const ACCESS_CONTROL_ALLOW_HEADERS = 'Access-Control-Allow-Headers';
  static const ACCESS_CONTROL_ALLOW_METHODS = 'Access-Control-Allow-Methods';
  static const ACCESS_CONTROL_MAX_AGE = 'Access-Control-Max-Age';
  static const VARY = 'Vary';

  static const ORIGIN = 'origin';

  static const _defaultHeadersList = [
    'accept',
    'accept-encoding',
    'authorization',
    'content-type',
    'dnt',
    'origin',
    'user-agent',
  ];

  static const _defaultMethodsList = [
    'DELETE',
    'GET',
    'OPTIONS',
    'PATCH',
    'POST',
    'PUT',
  ];

  static final Map<String, String> _defaultHeaders = {
    ACCESS_CONTROL_EXPOSE_HEADERS: '',
    ACCESS_CONTROL_ALLOW_CREDENTIALS: 'true',
    ACCESS_CONTROL_ALLOW_HEADERS: _defaultHeadersList.join(','),
    ACCESS_CONTROL_ALLOW_METHODS: _defaultMethodsList.join(','),
    ACCESS_CONTROL_MAX_AGE: '86400',
  };

  static final _defaultHeadersAll = _defaultHeaders.map(
    (key, value) => MapEntry(key, [value]),
  );

  static bool originAllowAll(String origin) => true;

  static OriginChecker originOneOf(List<String> origins) =>
      (origin) => origins.contains(origin);

  static Middleware makeMiddleware({
    Map<String, String>? headers,
    OriginChecker originChecker = originAllowAll,
  }) {
    final headersAll = headers?.map((key, value) => MapEntry(key, [value]));
    return (Handler handler) {
      return (Request request) async {
        final origin = request.headers[ORIGIN];

        if (origin == null || !originChecker(origin)) {
          return handler(request);
        }

        final _headers = <String, List<String>>{
          ..._defaultHeadersAll,
          ...?headersAll,
        };

        final userProvidedAccessControlAllowOrigin =
            headers?[ACCESS_CONTROL_ALLOW_ORIGIN];

        if (userProvidedAccessControlAllowOrigin != null) {
          _headers[ACCESS_CONTROL_ALLOW_ORIGIN] = [
            userProvidedAccessControlAllowOrigin,
          ];
          _headers[VARY] = ['Origin'];
        } else {
          _headers[ACCESS_CONTROL_ALLOW_ORIGIN] = [origin];
        }

        if (request.method == 'OPTIONS') {
          return Response.ok(null, headers: _headers);
        }

        final response = await handler(request);

        return response.change(
          headers: {
            ..._headers,
            ...response.headersAll,
          },
        );
      };
    };
  }
}
