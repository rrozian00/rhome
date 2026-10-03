import 'package:dartz/dartz.dart';
import 'package:rhome/cores/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  Future<Either<Failure, void>> saveIpToLocal(String ipAddress) async {
    try {
      final pref = await SharedPreferences.getInstance();
      await pref.setString("ipAddress", ipAddress);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, String>> getLocalIp() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final ip = pref.getString("ipAddress");
      return Right(ip!);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, List<String>>> updateLocalRelayNames(
    List<String> names,
  ) async {
    try {
      final pref = await SharedPreferences.getInstance();

      await pref.setStringList("relayNames", names);
      return Right(names);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, List<String>>> getLocalRelayNames() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final names = pref.getStringList("relayNames");
      return Right(names ?? []);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
