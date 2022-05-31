import 'package:logger/logger.dart';

final _logger = Logger();

void logError(dynamic msg, [dynamic e, StackTrace? s]) => _logger.e(msg, e, s);

void logInfo(dynamic msg, [dynamic e, StackTrace? s]) => _logger.i(msg, e, s);
