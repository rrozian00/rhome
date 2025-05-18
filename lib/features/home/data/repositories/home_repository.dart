import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:rhome/cores/error/failure.dart';

class HomeRepository {
  final String esp32Ip = "192.168.0.110"; // ← IP ESP32 kamu

  Future<Either<Failure, http.Response>> getResponseOn(int index) async {
    try {
      final result = await http.get(
        Uri.parse("http://$esp32Ip/on${index + 1}"),
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

  Future<Either<Failure, http.Response>> getResponseOff(int index) async {
    try {
      final result = await http.get(
        Uri.parse("http://$esp32Ip/off${index + 1}"),
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
}
