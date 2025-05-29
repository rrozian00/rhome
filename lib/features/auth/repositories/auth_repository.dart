import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rhome/features/auth/models/user_model.dart';

class AuthRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  /// Ambil user yang sedang login
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Login menggunakan Google Sign-In
  Future<UserCredential?> _signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print("Google Sign-In error: $e");
      return null;
    }
  }

  /// Login dengan akun Google dan simpan data ke Firestore jika user baru
  Future<void> login() async {
    try {
      final userCredential = await _signInWithGoogle();
      if (userCredential == null || userCredential.user == null) return;

      final user = userCredential.user!;
      final dataUser = UserModel.fromFirebaseUser(user);

      final userDoc = _firestore.collection("users").doc(user.uid);
      final userSnapshot = await userDoc.get();

      if (!userSnapshot.exists) {
        await userDoc.set(dataUser.toMap());
      }
    } catch (e) {
      print("Login error: $e");
      rethrow; // Biarkan Bloc atau UI menangani error
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
