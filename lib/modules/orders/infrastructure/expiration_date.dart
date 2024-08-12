class ExpirationDate {
  final DateTime? date;

  const ExpirationDate._(this.date);

  const ExpirationDate(DateTime date) : this._(date);
  const ExpirationDate.infinite() : this._(null);

  bool isExpired(DateTime now) => date != null && date!.isBefore(now);

  @override
  bool operator ==(covariant ExpirationDate other) {
    if (identical(this, other)) return true;

    return other.date == date;
  }

  @override
  int get hashCode => date.hashCode;
}
