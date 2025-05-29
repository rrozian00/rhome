import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rhome/features/setting/models/ip_model.dart';

class SettingRepo {
  //TODO:masih hard id
  final _firebase = FirebaseFirestore.instance;

  Future<String> getUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return "";
    return user.uid;
  }

  Future<void> saveIpAddress(String ipAddress) async {
    // final userId = await getUserId();
    final userId = "123123";
    if (userId == '') return;

    final docRef = _firebase.collection("users/$userId/ipAddress").doc();
    final data = IpModel(ipAddress: ipAddress);
    await docRef.set(data.toMap());
  }

  Future<void> updateIpAddress(String ipAddress) async {
    // final userId = await getUserId();
    final userId = "123123";
    if (userId == '') return;

    final docRef = _firebase
        .collection("users/$userId/ipAddress")
        .doc("123123");
    final data = IpModel(ipAddress: ipAddress);
    await docRef.update(data.toMap());
  }

  Future<String?> getIpAddress() async {
    final userId = "123123";

    final ip = await _firebase.collection("users/$userId/ipAddress").get();

    if (ip.docs.isEmpty) return null;
    final ipResult = ip.docs.map((e) => IpModel.fromMap(e.data())).toList();
    return ipResult.first.ipAddress;
  }
}
