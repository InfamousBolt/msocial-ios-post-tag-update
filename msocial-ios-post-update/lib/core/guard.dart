import 'logger.dart';

T? guard<T>(T Function() callback, [T? defaultValue, bool log = false]) {
  T? result;
  try {
    result = callback();
  } catch (e) {
    if (log) logError(e);
  }
  return result ?? defaultValue;
}

Future<T?> asyncGuard<T>(
  Future<T> Function() callback, [
  T? defaultValue,
  bool log = false,
]) async {
  T? result;
  try {
    result = await callback();
  } catch (e) {
    if (log) logError(e);
  }
  return result ?? defaultValue;
}
