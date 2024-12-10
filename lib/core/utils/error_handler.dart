import 'dart:convert';

import 'package:dartz/dartz.dart';

typedef DataResponse<T> = Future<Either<Failure, T>>;
typedef FromJson<T> = T Function(Map<String, dynamic> body);

extension HandleError on Future<dynamic> {
  DataResponse<T> map<T>(FromJson<T> f) async {
    try {
      final response = await this;
      return Right(f(jsonDecode(response)));
    } catch (e) {
      final Failure failure = Failure(e.toString());
      return Left(failure);
    }
  }
}

class Failure implements Exception {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}
