
import 'package:get/get.dart';

class Morning
{

  final String slot;
  final String orslot;
  final bool is_booked;
  final int time_token;

  const Morning(
      {
        required this.slot,
        required this.orslot,
        required this.is_booked,
        required this.time_token
      });

  factory Morning.fromJson(Map<String, dynamic> json)
  {
    // print ('Morning is_booked:: ${ json["is_booked"] }    ::: time is::  ${json["slot"]}');
    return Morning(
        orslot: json["slot"] ,
        slot: json["slot"] +" "+   'app.morning'.tr  ,
        is_booked: json["is_booked"],
        time_token: json["time_token"]
    );
  }
}




class Afternoon
{
  final String slot;
  final String orslot;
  final bool is_booked;
  final int time_token;

  const Afternoon(
      {
        required this.slot,
        required this.orslot,
        required this.is_booked,
        required this.time_token
      });

  factory Afternoon.fromJson(Map<String, dynamic> json)
  {
    var slot   =  json["slot"].split(':');
    var hours    = int.parse(slot[0]);
    hours = hours > 12 ?  hours -12  :  hours ;
    var timeslot =  hours.toString()+":"+ slot[1]+":"+slot[2]+" "+ 'app.afternoon'.tr ;

    // print ('Morning is_booked:: ${ json["is_booked"] }    ::: time is::  ${timeslot}');

    return Afternoon(
        slot: timeslot,
        orslot: json["slot"] ,
        is_booked: json["is_booked"],
        time_token: json["time_token"]
    );
  }
}



class Evening
{
  final String slot;
  final String orslot;
  final bool is_booked;
  final int time_token;

  const Evening(
      {
        required this.slot,
        required this.orslot,
        required this.is_booked,
        required this.time_token
      });

  factory Evening.fromJson(Map<String, dynamic> json)
  {

     var slot   =  json["slot"].split(':');
     var hours    = int.parse(slot[0]);
     hours = hours > 12 ?  hours -12  :  hours ;
     var timeslot =  hours.toString()+":"+ slot[1]+":"+slot[2]+" "+ 'app.evening'.tr ;

     // print ('Morning is_booked:: ${ json["is_booked"] }    ::: time is::  ${timeslot}');


    return Evening(
        slot: timeslot ,
        orslot:   json["slot"] ,
        is_booked: json["is_booked"],
        time_token: json["time_token"]
    );
  }
}


