abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});
}

class CacheFailure extends Failure {
  CacheFailure({required super.errorMessage});
}
