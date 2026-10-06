import 'package:dartz/dartz.dart';
import 'package:rhome/cores/database/database_helper.dart';
import 'package:rhome/cores/error/failure.dart';
import 'package:rhome/cores/models/button_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalRepository {
  Future<Either<Failure, void>> saveButton(ButtonModel button) async {
    final db = await DatabaseHelper.database;

    try {
      await db.insert(DatabaseHelper.buttonTable, button.toMap());
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, List<ButtonModel>>> getButtons() async {
    final db = await DatabaseHelper.database;

    try {
      final buttonRes = await db.query(DatabaseHelper.buttonTable);
      final buttons = buttonRes.map((e) => ButtonModel.fromMap(e)).toList();
      return Right(buttons);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteButton(int id) async {
    final db = await DatabaseHelper.database;

    try {
      await db.delete(
        DatabaseHelper.buttonTable,
        where: 'id = ?',
        whereArgs: [id],
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> updateButton(ButtonModel button) async {
    final db = await DatabaseHelper.database;

    try {
      await db.update(
        DatabaseHelper.buttonTable,
        button.toMap(),
        where: 'id = ?',
        whereArgs: [button.id],
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> saveIpToLocal(String ipAddress) async {
    final db = await DatabaseHelper.database;

    try {
      await db.insert(DatabaseHelper.ipTable, {
        'id': 1,
        'ipAddress': ipAddress,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, String>> getIpFromLocal() async {
    final db = await DatabaseHelper.database;

    try {
      final ipRes = await db.query(DatabaseHelper.ipTable);
      final ipAddress = ipRes.first['ipAddress'] as String;
      return Right(ipAddress);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
