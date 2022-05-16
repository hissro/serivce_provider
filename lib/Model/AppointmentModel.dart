


class Appointment
{

  /*
      private String id;
      private String user_id;
      private String bus_id;
      private String appointment_date;
      private String start_time;
      private String time_token;
      private String status;
      private String app_name;
      private String app_email;
      private String app_phone;
      private String created_at;
      private String bus_title;
      private String bus_slug;
      private String bus_email;
      private String bus_latitude;
      private String bus_longitude;
      private String bus_contact;
      private String bus_logo;
      private String bus_fee;
      private String currency;
      private String doct_name;
      private String doct_degree;
      private String payment_type;
      private String payment_mode;
      private String payment_ref;
      private String payment_amount;
  */

    final String id;
    final String user_id;
    final String bus_id;
    final String appointment_date;
    final String start_time;
    final String time_token;
    final String status;
    final String app_name;
    final String bus_title;
    final String doct_name;
    final String time ;

    const Appointment(
    {
    required this.id,
    required this.user_id,
    required this.bus_id,
    required this.appointment_date,
    required this.start_time,
    required this.time_token,
    required this.status,
    required this.app_name,
    required this.bus_title,
    required this.doct_name,
    required this.time
    });

    factory Appointment.fromJson(Map<String, dynamic> json)
    {
      var slot   =  json["start_time"].split(':');
      var hours    = int.parse(slot[0]);
      hours = hours > 12 ?  hours -12  :  hours ;
      var timeslot =  hours.toString()+":"+ slot[1]+":"+slot[2]+ " مساء " ;


      return Appointment(
          id: json["id"],
          user_id: json["user_id"],
          bus_id: json["bus_id"],
          appointment_date: json["appointment_date"],
          start_time: json["start_time"],
          time_token: json["time_token"],
          status: json["status"],
          app_name: json["app_name"],
          bus_title: json["bus_title"],
          doct_name:  json["doct_name"],
          time: timeslot
      );
    }




}