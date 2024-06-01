class BookingFailure {
  final String message;

  BookingFailure(this.message);
}

class BookingNotFoundFailure extends BookingFailure {
  BookingNotFoundFailure(String message) : super(message);
}

class BookingAlreadyExistsFailure extends BookingFailure {
  BookingAlreadyExistsFailure(String message) : super(message);
}