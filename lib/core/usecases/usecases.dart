import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/core/error/faliures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
