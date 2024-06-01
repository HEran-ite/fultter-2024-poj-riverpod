class UserId {
  final String value;

  UserId(this.value) {
    if (value.isEmpty) {
      throw Exception("UserId cannot be empty");
    }
  }
}

class UserName {
  final String value;

  UserName(this.value) {
    if (value.isEmpty) {
      throw Exception("UserName cannot be empty");
    }
  }
}

class UserEmail {
  final String value;

  UserEmail(this.value) {
    if (value.isEmpty) {
      throw Exception("UserEmail cannot be empty");
    }
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(value)) {
      throw Exception("Invalid email format");
    }
  }
}

class UserPassword {
  final String value;

  UserPassword(this.value) {
    if (value.length < 6) {
      throw Exception("UserPassword must be at least 6 characters long");
    }
  }
}

class UserRole {
  final String value;

  UserRole(this.value) {
    if (value.isEmpty) {
      throw Exception("UserRole cannot be empty");
    }
    if (value != 'admin' && value != 'customer') {
      throw Exception("Invalid UserRole");
    }
  }
}