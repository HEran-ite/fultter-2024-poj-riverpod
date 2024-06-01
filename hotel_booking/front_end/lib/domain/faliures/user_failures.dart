
class UserFailure {
  final String message;

  UserFailure(this.message);
}

class UserNotFoundFailure extends UserFailure {
  UserNotFoundFailure(String message) : super(message);
}

class UserAlreadyExistsFailure extends UserFailure {
  UserAlreadyExistsFailure(String message) : super(message);
}

