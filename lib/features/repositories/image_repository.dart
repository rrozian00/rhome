import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cores/error/failure.dart';

class ImageRepository {
  final firestore = FirebaseFirestore.instance;
  final ImagePicker picker;

  ImageRepository({
    required this.picker, // required this.remoteRepo
  });

  Future<Either<Failure, String>> setImage(int index) async {
    try {
      final imageSrc = await picker.pickImage(source: ImageSource.gallery);
      final shared = await SharedPreferences.getInstance();

      if (imageSrc != null) {
        await shared.setString("image$index", imageSrc.path);
        final path = shared.getString("image$index") ?? '';
        return Right(path);
      } else {
        return left(Failure("Image is not picked"));
      }
    } catch (e) {
      return Left(Failure("Unexpected error $e"));
    }
  }

  Future<Either<Failure, void>> resetImage(int index) async {
    try {
      final shared = await SharedPreferences.getInstance();
      await shared.setString("image$index", '');
      return const Right(null);
    } catch (e) {
      return Left(Failure("Unexpected error $e"));
    }
  }

  Future<Either<Failure, List<String>>> getImages() async {
    try {
      final shared = await SharedPreferences.getInstance();

      final images = List<String>.generate(4, (index) {
        return shared.getString("image$index") ?? '';
      });

      return Right(images);
    } catch (e) {
      return Left(Failure("Unexpected error $e"));
    }
  }
}
