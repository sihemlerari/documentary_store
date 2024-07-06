abstract class InfrastructureException implements Exception {
  final String message;

  const InfrastructureException(this.message);

  @override
  bool operator ==(covariant InfrastructureException other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class TimeoutException extends InfrastructureException {
  const TimeoutException() : super('Timeout');
}

class NetworkException extends InfrastructureException {
  const NetworkException() : super('No internet connection');
}

class PermissionDeniedException extends InfrastructureException {
  const PermissionDeniedException() : super('Permission denied');
}
