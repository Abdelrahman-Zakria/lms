class LoginRequestModel {
  final String emailOrPhone;
  final String password;
  final String type;
  final String notiId;
  final String mobileId;
  final String mobileType;

  const LoginRequestModel({
    required this.emailOrPhone,
    required this.password,
    required this.type,
    required this.notiId,
    required this.mobileId,
    required this.mobileType,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      emailOrPhone: json['email_or_phone'] ?? '',
      password: json['password'] ?? '',
      type: json['type'] ?? '',
      notiId: json['noti_id'] ?? '',
      mobileId: json['mobile_id'] ?? '',
      mobileType: json['mobile_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email_or_phone': emailOrPhone,
      'password': password,
      'type': type,
      'noti_id': notiId,
      'mobile_id': mobileId,
      'mobile_type': mobileType,
    };
  }
}
