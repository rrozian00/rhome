import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../error/failure.dart';
import 'dart:convert';

class HttpResponseHelper {
  Future<Either<Failure, bool>> getResponseStatus(String ipAddress) async {
    try {
      final response = await http
          .get(Uri.parse("http://$ipAddress/status"))
          .timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        return Right(true);
      } else {
        return Right(false);
      }
    } catch (e) {
      return Left(Failure("Unexpexted error $e"));
    }
  }

  Future<Either<Failure, http.Response>> getResponseOn(
    int index,
    String ipAddress,
  ) async {
    try {
      final result = await http.get(
        Uri.parse("http://$ipAddress/on${index + 1}"),
      );

      if (result.statusCode == 200) {
        return Right(result);
      } else {
        return Left(Failure("The response is ${result.statusCode}"));
      }
    } catch (e) {
      return Left(Failure("Unexpexted error $e"));
    }
  }

  Future<Either<Failure, http.Response>> getResponseOff(
    int index,
    String ipAddress,
  ) async {
    try {
      final result = await http.get(
        Uri.parse("http://$ipAddress/off${index + 1}"),
      );

      if (result.statusCode == 200) {
        return Right(result);
      } else {
        return Left(Failure("The response is ${result.statusCode}"));
      }
    } catch (e) {
      return Left(Failure("Unexpexted error $e"));
    }
  }

  Future<Either<Failure, List<bool>>> getRelayStatus(String ipAddress) async {
    try {
      final result = await http.get(Uri.parse("http://$ipAddress/status"));

      if (result.statusCode == 200) {
        final data = jsonDecode(result.body);

        final statusList =
            [
              data["relay1"],
              data["relay2"],
              data["relay3"],
              data["relay4"],
            ].cast<bool>();

        return Right(statusList);
      } else {
        return Left(Failure("The response is ${result.statusCode}"));
      }
    } catch (e) {
      return Left(Failure("Unexpected error $e"));
    }
  }
}
