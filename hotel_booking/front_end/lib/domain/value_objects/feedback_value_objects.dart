class FeedbackId {
  final String value;

  FeedbackId(this.value) {
    if (value.isEmpty) {
      throw Exception("FeedbackId cannot be empty");
    }
  }
}

class FeedbackUserId {
  final String value;

  FeedbackUserId(this.value) {
    if (value.isEmpty) {
      throw Exception("FeedbackUserId cannot be empty");
    }
  }
}

class FeedbackMessage {
  final String value;

  FeedbackMessage(this.value) {
    if (value.isEmpty) {
      throw Exception("FeedbackMessage cannot be empty");
    }
  }
}

class FeedbackDate {
  final DateTime value;

  FeedbackDate(this.value) {
    if (value.isAfter(DateTime.now())) {
      throw Exception("FeedbackDate cannot be in the future");
    }
  }
}