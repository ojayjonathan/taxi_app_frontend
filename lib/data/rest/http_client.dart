part of 'client.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      //TODO:logout the user
    }
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = {...options.headers, "Authorization": "Token"};
    super.onRequest(options, handler);
  }
}

final httpClient = Dio(
  BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: 10000,
    sendTimeout: 30000,
    receiveTimeout: 30000,
  ),
)..interceptors.add(
    ApiInterceptor(),
  );

typedef Deserializer<X> = X Function(dynamic data);
typedef Result<T> = Future<HttpResult<T>>;

class Http {
  static Result<T> get<T>(
    String url, {
    Deserializer<T>? deserializer,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final res = await httpClient.get(url, queryParameters: queryParams);
      return HttpResult<T>.onSuccess(
        data: deserializer != null ? (res.data) : res.data,
      );
    } catch (e) {
      return HttpResult.onError(error: getException(e));
    }
  }

  static Result<T> post<T>(
    String url,
    Map data, {
    Deserializer<T>? deserializer,
  }) async {
    try {
      final res = await httpClient.post(url, data: data);
      return HttpResult.onSuccess(
        data: deserializer != null ? (res.data) : res.data,
      );
    } catch (e) {
      return HttpResult.onError(error: getException(e));
    }
  }

  static Result<T> put<T>(
    String url,
    Map data, {
    Deserializer<T>? deserializer,
  }) async {
    try {
      final res = await httpClient.put(url, data: data);
      return HttpResult.onSuccess(
        data: deserializer != null ? (res.data) : res.data,
      );
    } catch (e) {
      return HttpResult.onError(error: getException(e));
    }
  }

  static Result<T> patch<T>(
    String url,
    Map data, {
    Deserializer<T>? deserializer,
  }) async {
    try {
      final res = await httpClient.patch(url, data: data);
      return HttpResult.onSuccess(
        data: deserializer != null ? (res.data) : res.data,
      );
    } catch (e) {
      return HttpResult.onError(error: getException(e));
    }
  }
}
