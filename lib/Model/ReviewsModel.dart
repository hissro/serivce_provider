
import '../Utilities/Config.dart';

class ReviewsModel
{
  final String id;
  final String bus_id ;
  final String user_id;
  final String reviews;
  final String ratings;
  final String on_date;
  final String user_fullname;
  final String user_image;



  const ReviewsModel(
      {
        required this.id,
        required this.bus_id,
        required this.user_id,
        required this.reviews,
        required this.ratings,
        required this.on_date,
        required this.user_fullname,
        required this.user_image
      });

  factory ReviewsModel.fromJson(Map<String, dynamic> json)
  {
    return ReviewsModel(
        id: json["id"],
        bus_id: json["bus_id"],
        user_id: json["user_id"],
        reviews: json["reviews"],
        ratings: json["ratings"],
        on_date: json["on_date"],
        user_fullname:  json["user_fullname"],
        user_image: Config.REVIEWS_IMAGE  + json["user_image"]
    );
  }
}
