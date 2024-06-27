abstract class DomainException implements Exception {
  final String message;

  const DomainException(this.message);

  @override
  bool operator ==(covariant DomainException other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class DocumentaryNotFound extends DomainException {
  final String documentaryId;

  const DocumentaryNotFound(this.documentaryId)
      : super('Documentary with id $documentaryId not found');
}
