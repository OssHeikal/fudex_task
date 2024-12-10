import 'dart:convert';

import 'package:dartz/dartz.dart';

typedef DataResponse<T> = Future<Either<Exception, T>>;
typedef FromJson<T> = T Function(Map<String, dynamic> body);

extension HandleError on Future<dynamic> {
  DataResponse<T> map<T>(FromJson<T> f) async {
    try {
      final response = await this;
      return Right(f(jsonDecode(response)));
    } catch (e) {
      return Left(e as Exception);
    }
  }
}
