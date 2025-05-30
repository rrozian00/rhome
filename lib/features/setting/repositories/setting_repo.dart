import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rhome/features/auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingRepo {
  //TODO:masih hard id

  //Remote
  final _firebase = FirebaseFirestore.instance;

  Future<String> getUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return "";
    return user.uid;
  }

  //Belum terpakai
  // Future<void> saveIpAddress(String ipAddress) async {
  //   // final userId = await getUserId();
  //   final userId = "123123";
  //   if (userId == '') return;

  //   final docRef = _firebase.collection("users/$userId").doc();
  //   final data = UserModel();
  //   final newData = data.copyWith(ipAddress: ipAddress);
  //   await docRef.set(newData.toMap());
  // }

  Future<void> updateIpAddress(String ipAddress) async {
    // final userId = await getUserId();
    final userId = "123123";

    final docRef = _firebase.collection("users").doc(userId);
    final data = UserModel();
    final dataUpdate = data.copyWith(ipAddress: ipAddress);
    await docRef.update(dataUpdate.toMap());
    await saveIpToLocal(ipAddress);
  }

  Future<String?> getIpAddress() async {
    try {
      final userId = "123123";

      final ip = await _firebase.collection("users").doc(userId).get();

      if (ip.exists) {
        final ipData = UserModel.fromMap(ip.data()!);
        return ipData.ipAddress;
      }
    } catch (e) {
      print(e.toString());
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
