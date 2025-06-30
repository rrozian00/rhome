import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rhome/cores/error/failure.dart';
import 'package:rhome/features/auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingRepository {
  //Remote
  final _firebase = FirebaseFirestore.instance;
  // final userId = '';

  Future<String> getUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return "";
    return user.uid;
  }

  Future<Either<Failure, UserModel>> getProfile() async {
    String userId = await getUserId();
    try {
      final userData = await _firebase
          .collection('users')
          .doc(userId)
          .get()
          .then((value) => UserModel.fromMap(value.data()!));
      return Right(userData);
    } catch (e) {
      return Left(Failure('$e'));
    }
  }

  Future<void> updateIpAddress(String ipAddress) async {
    final userId = await getUserId();

    final docRef = _firebase.collection("users").doc(userId);
    final data = UserModel();
    final dataUpdate = data.copyWith(ipAddress: ipAddress);
    await docRef.update(dataUpdate.toMap());
    await saveIpToLocal(ipAddress);
  }

  Future<String?> getIpAddress() async {
    try {
      final userId = await getUserId();
      final ip = await _firebase.collection("users").doc(userId).get();
      if (ip.exists) {
        final ipData = UserModel.fromMap(ip.data()!);
        return ipData.ipAddress;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //Local Storage
  Future<void> saveIpToLocal(String ipAddress) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("ipAddress", ipAddress);
  }

  Future<String?> getIpFromLocal() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("ipAddress");
  }

  Future<String?> getIpAll() async {
    final local = await getIpFromLocal();
    if (local != null && local.isNotEmpty) return local;

    final remote = await getIpAddress();
    return (remote != null && remote.isNotEmpty) ? remote : null;
  }
}
