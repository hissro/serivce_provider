import '../Utilities/Config.dart';

class BusinessModel
{

  final String  bus_id;
  final String user_id;
  final String bus_title;
  final String bus_slug;
  final String bus_email;
  final String bus_description;
  final String bus_logo;
  final String bus_status;
  final String bus_fee;
  final String bus_con_time;
  final String city_id;
  final String locality_id;
  final String country_id;
  final String ? currency;
  final String is_trusted;
  final String ? morning_time_start;
  final String ? working_days;
  final String user_fullname;
  final String ? evening_time_end ;
  final String total_rating;
  final String review_count;
  final String avg_rating;
  final String bus_google_street;
  final String bus_contact;
  final String? bus_latitude;
  final String? bus_longitude;



  const BusinessModel(
      {
        required this.bus_id,
        required this.user_id,
        required this.bus_title,
        required this.bus_slug,
        required this.bus_email,
        required this.bus_description,
        required this.bus_logo,
        required this.bus_status,
        required this.bus_fee,
        required this.bus_con_time,
        required this.city_id,
        required this.country_id,
        required this.locality_id,
        required this.is_trusted,
        required this.currency,
        required this.working_days,
        required this.morning_time_start,
        required this.evening_time_end,
        required this.user_fullname,
        required this.avg_rating,
        required this.total_rating,
        required this.review_count ,
        required this.bus_google_street ,
        required this.bus_contact,
        required this.bus_latitude,
        required this.bus_longitude,

      });

  factory BusinessModel.fromJson(Map<String, dynamic> json)
  {

    return BusinessModel(
      bus_id: json["bus_id"],
      user_id: json["user_id"],
      bus_title: json["bus_title"],
      bus_slug: json["bus_slug"],
      bus_email: json["bus_email"],
      bus_description: json["bus_description"],
      bus_logo: Config.BUSINESS_IMAGE + json["bus_logo"],
      bus_status: json["bus_status"],
      bus_fee: json["bus_fee"]==  null ? "0":json["bus_fee"] ,
      bus_con_time: json["bus_con_time"] ==  null ? "0":json["bus_con_time"] ,
      city_id: json["city_id"],
      country_id: json["country_id"],
      locality_id: json["locality_id"],
      is_trusted: json["is_trusted"],
      currency: json["currency"],
      working_days: json["working_days"],
      morning_time_start: json["morning_time_start"],
      evening_time_end: json["evening_time_end"],
      user_fullname: json["user_fullname"],
      avg_rating: json["avg_rating"],
      total_rating: json["total_rating"],
      review_count: json["review_count"],
      bus_google_street:json["bus_google_street"],
      bus_contact:json["bus_contact"],
      bus_latitude : json["bus_latitude"],
      bus_longitude:json["bus_longitude"]
    );

  }
}
