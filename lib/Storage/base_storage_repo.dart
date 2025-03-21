import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

abstract class BaseStorageRepo {
  // Future<void>uploadImage(XFile image);
  Future<void> uploadImage(CroppedFile image1, XFile image);
  Future<String> getDownloadurl(String imageName);
}
