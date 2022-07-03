
class UserModel
{


  final String user_id;
  final String user_fullname;
  final String user_email;
  final String user_phone;
  final String user_type_id;
  final bool IsLogin;

  const UserModel(
      {
        required this.user_id,
        required this.user_fullname,
        required this.user_email,
        required this.user_phone,
        required this.user_type_id,
        required this.IsLogin, required
      });

  factory UserModel.fromJson(Map<String, dynamic> json)
  {
    return UserModel(
        user_id: json["user_id"],
        user_fullname: json["user_fullname"],
        user_email: json["user_email"],
        user_phone:   json["user_phone"],
        user_type_id:   json["user_type_id"],
        IsLogin : true
    );
  }


}