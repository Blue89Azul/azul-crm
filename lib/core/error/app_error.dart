// エラー発生時のレイヤー
enum ErrorLayer { data, domain, presentation }

class AppError implements Exception {
  final ErrorLayer layer;
  final String message;
  final StackTrace? stackTrace;

  const AppError({required this.layer, required this.message, this.stackTrace});

  @override
  String toString() => '[${layer.name.toUpperCase()}] $message \n ${stackTrace ?? ''}';
}
