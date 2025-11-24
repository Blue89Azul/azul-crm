import 'package:azul_crm/features/auth/data/repositories/jwt_repository_interface.dart';
import 'package:dio/dio.dart';

class AppApiClient {
  final JwtRepositoryInterface _jwtRepository;
  late final Dio _dio;

  AppApiClient(this._jwtRepository) {
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://localhost/api", // これを後ほど変更
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        responseType: ResponseType.json,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final result = await _jwtRepository.getToken();
          result.fold((_) => null, (token) {
            if (token == null) {
              return handler.next(options);
            }
            options.headers['Authorization'] = '${token.tokenType} ${token.token}';
          });
          return handler.next(options);
        },
        onError: (exception, handler) async {
          if (exception.response?.statusCode == 401) {
            _jwtRepository.deleteToken();
          }
          handler.next(exception);
        }
      ),
    );
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
    String path, {
    required Object data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        data: data,
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
