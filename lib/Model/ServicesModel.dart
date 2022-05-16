class ServicesModel
{
  late bool isclicked ;
  final String id;
  final String bus_id;
  final String service_title;
  final double service_price;
  final String service_discount;
  final String business_approxtime;
  final double toutal ;

    ServicesModel(
      {
        required this.isclicked,
        required this.id,
        required this.bus_id,
        required this.service_title,
        required this.service_price,
        required this.service_discount,
        required this.business_approxtime,
        required this.toutal
      });

  factory ServicesModel.fromJson(Map<String, dynamic> json)
  {

    // Get Reall Price
    var amount =  double.parse(json["service_price"]);

    // Cal The Discount Price
    var discount = double.parse(json["service_discount"]) * amount / 100;

    // The Final Price
    var finalAmount = amount - discount;

    // print ("service title:${json["service_title"]}  Amount: "+amount.toString()+ " -- Discount:"+discount.toString() + "   Total: "+final_amount.toString());

    return ServicesModel(
      isclicked: false ,
      id: json["id"],
      bus_id: json["bus_id"],
      service_title: json["service_title"],
      service_price: amount,
      service_discount: json["service_discount"],
      business_approxtime: json["business_approxtime"],
      toutal: finalAmount,
    );
  }


}
