
import '../Utilities/Config.dart';

class EmployeeModel
{
  final String doct_id;
  final String bus_id ;
  final String doct_name;
  final String doct_degree;
  final String doct_phone;
  final String doct_email;
  final String doct_speciality;
  final String doct_photo;
  final String doct_about;



  const EmployeeModel(
      {
        required this.doct_id,
        required this.bus_id,
        required this.doct_name,
        required this.doct_degree,
        required this.doct_phone,
        required this.doct_email,
        required this.doct_speciality,
        required this.doct_photo,
        required this.doct_about
      });

  factory EmployeeModel.fromJson(Map<String, dynamic> json)
  {
    return EmployeeModel(
      doct_id: json["doct_id"],
      bus_id: json["bus_id"],
      doct_name: json["doct_name"],
      doct_degree: json["doct_degree"],
      doct_phone: json["doct_phone"],
      doct_email: json["doct_email"],
      doct_speciality:  json["doct_speciality"],
      doct_photo: Config.BUSINESS_IMAGE  + json["doct_photo"],
      doct_about: json["doct_about"]
    );
  }
}
