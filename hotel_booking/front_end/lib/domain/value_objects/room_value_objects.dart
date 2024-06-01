class RoomId {
  final String value;

  RoomId(this.value) {
    if (value.isEmpty) {
      throw Exception("RoomId cannot be empty");
    }
  }
}

class RoomTitle {
  final String value;

  RoomTitle(this.value) {
    if (value.isEmpty) {
      throw Exception("RoomTitle cannot be empty");
    }
  }
}

class RoomImage {
  final String value;

  RoomImage(this.value) {
    if (value.isEmpty) {
      throw Exception("RoomImage cannot be empty");
    }
  }
}

class RoomDescription {
  final String value;

  RoomDescription(this.value) {
    if (value.isEmpty) {
      throw Exception("RoomDescription cannot be empty");
    }
  }
}

class RoomPrice {
  final int value;

  RoomPrice(this.value) {
    if (value <= 0) {
      throw Exception("RoomPrice must be greater than zero");
    }
  }
}

class RoomCategory {
  final String value;

  RoomCategory(this.value) {
    if (value.isEmpty) {
      throw Exception("RoomCategory cannot be empty");
    }
  }
}