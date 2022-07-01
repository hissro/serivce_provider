
class MyOrderModel
{
  final String id;
  final String bus_title;
  final String app_name;
  final String app_phone;
  final String app_email;
  final String status;
  final String created_at;
  final String appointment_date;
  final String bus_description;



  const MyOrderModel  (
      {
        required this.id,
        required this.bus_title,
        required this.app_name,
        required this.app_phone,
        required this.app_email,
        required this.status,
        required this.created_at,
        required this.appointment_date,
        required this.bus_description,

      });

  factory MyOrderModel.fromJson(Map<String, dynamic> json)
  {
    RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);
    var c = json["bus_description"].replaceAll(exp, ' ') ;
      c = c.replaceAll("&nbsp;", ' ') ;

    return MyOrderModel(
      id: json["id"],
      bus_title: json["bus_title"],
      app_name: json["app_name"],
      app_phone: json["app_phone"],
      app_email: json["app_email"],
      status: json["status"],
      created_at: json["created_at"],
      appointment_date: json["appointment_date"],
      bus_description:c ,

    );
  }

}