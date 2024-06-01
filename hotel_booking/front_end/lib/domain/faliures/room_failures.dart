class RoomFailure {
  final String message;

  RoomFailure(this.message);
}

class RoomNotFoundFailure extends RoomFailure {
  RoomNotFoundFailure(String message) : super(message);
}

class RoomAlreadyExistsFailure extends RoomFailure {
  RoomAlreadyExistsFailure(String message) : super(message);
}