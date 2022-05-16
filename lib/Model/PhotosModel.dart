import '../Utilities/Config.dart';

class PhotosModel
{
  final String id;
  final String bus_id;
  final String photo_title;
  final String photo_image;

  const PhotosModel(
      {
        required this.id,
        required this.bus_id,
        required this.photo_title,
        required this.photo_image
      });

  factory PhotosModel.fromJson(Map<String, dynamic> json)
  {
    return PhotosModel(
      id: json["id"],
      bus_id: json["bus_id"],
      photo_title: json["photo_title"],
      photo_image: Config.REVIEWS_PHOTOS  + json["photo_image"]
    );
  }
}
