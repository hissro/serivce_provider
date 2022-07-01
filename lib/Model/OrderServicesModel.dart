

class OrderServicesModel
{
  final String service_price;
  final String service_title;


  const OrderServicesModel(
      {
        required this.service_price,
        required this.service_title
      });

  factory OrderServicesModel.fromJson(Map<String, dynamic> json)
  {
    return OrderServicesModel(
        service_price: json["service_price"],
      service_title: json["service_title"]
    );
  }
}