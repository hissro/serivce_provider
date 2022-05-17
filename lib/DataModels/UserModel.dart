


class UserModel{

  // user_id: 14, user_fullname: salah omer, user_email: hissro@gmail.com, user_phone: 0564899833

  final String user_id;
  final String user_fullname;
  final String user_email;
  final String user_phone;
  final bool IsLogin;

  const UserModel(
      {
        required this.user_id,
        required this.user_fullname,
        required this.user_email,
        required this.user_phone,
        required this.IsLogin
      });

  factory UserModel.fromJson(Map<String, dynamic> json)
  {
    return UserModel(
        user_id: json["user_id"],
        user_fullname: json["user_fullname"],
        user_email: json["user_email"],
        user_phone:   json["user_phone"],
        IsLogin : true
    );
  }


}