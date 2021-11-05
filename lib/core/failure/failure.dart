class Failure {
  late String message;
}

class ServerFailure extends Failure {
  final String message;
  ServerFailure(this.message);
}
