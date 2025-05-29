import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:rhome/cores/error/failure.dart';
import 'package:rhome/features/setting/repositories/setting_repo.dart';

class HomeRepository {
  // static String esp32Ip = "192.168.0.110"; // ← IP ESP32 kamu

  Future<String?> getIp() async {
    final settingRepo = SettingRepo();

    final data = await settingRepo.getIpAddress();
    if (data != null && data != "") {
      return data;
    }
    return null;
  }

  Future<Either<Failure, http.Response>> getResponseOn(
    int index,
    String esp32Ip,
  ) async {
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

  Future<Either<Failure, http.Response>> getResponseOff(
    int index,
    String esp32Ip,
  ) async {
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

  Future<Either<Failure, List<bool>>> getRelayStatus(String esp32Ip) async {
    try {
      final result = await http.get(Uri.parse("http://$esp32Ip/status"));
      if (result.statusCode == 200) {
        final body = result.body.trim();
        final statusList = body.split('').map((e) => e == "1").toList();
        return Right(statusList);
      } else {
        return Left(Failure("The response is ${result.statusCode}"));
      }
    } catch (e) {
      return Left(Failure("Unexpexted error $e"));
    }
  }
}
