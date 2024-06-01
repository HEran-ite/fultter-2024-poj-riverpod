class FeedbackFailure {
  final String message;

  FeedbackFailure(this.message);
}

class FeedbackNotFoundFailure extends FeedbackFailure {
  FeedbackNotFoundFailure(String message) : super(message);
}

class FeedbackAlreadyExistsFailure extends FeedbackFailure {
  FeedbackAlreadyExistsFailure(String message) : super(message);
}