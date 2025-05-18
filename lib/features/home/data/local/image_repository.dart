import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rhome/cores/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageRepository {
  final picker = ImagePicker();

  Future<Either<Failure, bool>> setImage(int index) async {
    try {
      final imageSrc = await picker.pickImage(source: ImageSource.gallery);
      final shared = await SharedPreferences.getInstance();
      if (imageSrc != null) {
        final result = await shared.setString("image$index", imageSrc.path);
        return Right(result);
      } else {
        return left(Failure("Image is not picked"));
      }
    } catch (e) {
      return Left(Failure("Unexpected error $e"));
    }
  }

  Future<Either<Failure, List<String>>> getImages() async {
    try {
      final shared = await SharedPreferences.getInstance();
      final result = List.generate(
        4,
        (index) => shared.getString("image$index") ?? '',
      );

      return Right(result);
    } catch (e) {
      return Left(Failure("Unexpected error $e"));
    }
  }
}
