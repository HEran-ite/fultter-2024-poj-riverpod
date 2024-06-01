class BookingId {
  final String value;

  BookingId(this.value) {
    if (value.isEmpty) {
      throw Exception("BookingId cannot be empty");
    }
  }
}

class BookingUserId {
  final String value;

  BookingUserId(this.value) {
    if (value.isEmpty) {
      throw Exception("BookingUserId cannot be empty");
    }
  }
}

class BookingRoomId {
  final String value;

  BookingRoomId(this.value) {
    if (value.isEmpty) {
      throw Exception("BookingRoomId cannot be empty");
    }
  }
}

class BookingStartDate {
  final DateTime value;

  BookingStartDate(this.value) {
    if (value.isAfter(DateTime.now())) {
      throw Exception("BookingStartDate cannot be in the future");
    }
  }
}

class BookingEndDate {
  final DateTime value;

  BookingEndDate(this.value) {
    if (value.isBefore(DateTime.now())) {
      throw Exception("BookingEndDate cannot be in the past");
    }
  }
}

class BookingTotalPrice {
  final double value;

  BookingTotalPrice(this.value) {
    if (value <= 0) {
      throw Exception("BookingTotalPrice must be greater than zero");
    }
  }
}