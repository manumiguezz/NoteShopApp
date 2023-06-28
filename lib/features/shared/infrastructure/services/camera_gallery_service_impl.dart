

import 'package:image_picker/image_picker.dart';
import 'package:noteshop/features/shared/infrastructure/services/camera_gallery_service.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {

  final ImagePicker picker = ImagePicker();

  @override
  Future<String?> selectPhoto() async{
    
    final XFile? photo = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    
    if(photo == null) return null;
    return photo.path;
  }

  @override
  Future<String?> takePhoto() async{
    
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear
    );
    
    if(photo == null) return null;
    return photo.path;
  }

}