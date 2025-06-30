import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rhome/cores/error/failure.dart';
import 'package:rhome/features/auth/models/user_model.dart';

class AuthRepository {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  User? getCurrentUser() {
    return auth.currentUser;
  }

  Future<Either<Failure, void>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final id = credential.user?.uid;
      final docRef = firestore.collection('users').doc(id);

      final data = UserModel(
        uid: id,
        name: name,
        email: email,
        photoUrl: credential.user?.photoURL,
      );
      await docRef.set(data.toMap());
      return Right(null);
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'weak-password':
          return Left(Failure('Password Lemah.'));

        case 'invalid-email':
          return Left(Failure('Format email tidak sesuai.'));

        case 'email-already-in-use':
          return Left(Failure('Email sudah terdaftar.'));

        default:
          print(e.code);
          return Left(Failure(e.code));
      }
    }
  }

  Future<Either<Failure, UserCredential>> login(
    String email,
    String password,
  ) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(credential);
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          return Left(Failure('Password anda salah.'));

        case 'invalid-email':
          return Left(Failure('Format email tidak sesuai.'));

        case 'invalid-credential':
          return Left(Failure('Email atau password salah.'));

        case 'network-request-failed':
          return Left(Failure('Tidak ada jaringan internet.'));

        default:
          print(e.code);
          return Left(Failure(e.code));
      }
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
