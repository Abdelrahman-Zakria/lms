import '../../domain/entities/user.dart';

class LoginResponseModel {
  final bool status;
  final String? message;
  final Map<String, dynamic>? errors;
  final LoginData? data;

  const LoginResponseModel({
    required this.status,
    this.message,
    this.errors,
    this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'] ?? false,
      message: json['message'],
      errors: json['errors'],
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'errors': errors,
      'data': data?.toJson(),
    };
  }
}

class LoginData {
  final String token;
  final UserLoginData loginData;

  const LoginData({
    required this.token,
    required this.loginData,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'] ?? '',
      loginData: UserLoginData.fromJson(json['login_data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'login_data': loginData.toJson(),
    };
  }
}

class UserLoginData {
  final int id;
  final String name;
  final String? email;
  final bool isVip;
  final int references;
  final int points;
  final int attendanceWeeks;
  final String phone;
  final int phoneVerified;
  final String? countryCode;
  final int fakeNumber;
  final String type;
  final String gendar;
  final String mobileId;
  final String mobileType;
  final String? img;
  final String? socialId;
  final String username;
  final String lock;
  final String? lockMessage;
  final int systemId;
  final int stageId;
  final int classroomId;
  final int termId;
  final int? pathId;
  final int? institutionId;
  final String createdAt;
  final String updatedAt;
  final SystemInfo system;
  final StageInfo stage;
  final ClassroomInfo classroom;
  final TermInfo term;

  const UserLoginData({
    required this.id,
    required this.name,
    this.email,
    required this.isVip,
    required this.references,
    required this.points,
    required this.attendanceWeeks,
    required this.phone,
    required this.phoneVerified,
    this.countryCode,
    required this.fakeNumber,
    required this.type,
    required this.gendar,
    required this.mobileId,
    required this.mobileType,
    this.img,
    this.socialId,
    required this.username,
    required this.lock,
    this.lockMessage,
    required this.systemId,
    required this.stageId,
    required this.classroomId,
    required this.termId,
    this.pathId,
    this.institutionId,
    required this.createdAt,
    required this.updatedAt,
    required this.system,
    required this.stage,
    required this.classroom,
    required this.term,
  });

  factory UserLoginData.fromJson(Map<String, dynamic> json) {
    return UserLoginData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'],
      isVip: json['is_vip'] ?? false,
      references: json['references'] ?? 0,
      points: json['points'] ?? 0,
      attendanceWeeks: json['attendance_weeks'] ?? 0,
      phone: json['phone'] ?? '',
      phoneVerified: json['phone_verified'] ?? 0,
      countryCode: json['country_code'],
      fakeNumber: json['fake_number'] ?? 0,
      type: json['type'] ?? '',
      gendar: json['gendar'] ?? '',
      mobileId: json['mobile_id'] ?? '',
      mobileType: json['mobile_type'] ?? '',
      img: json['img'],
      socialId: json['social_id'],
      username: json['username'] ?? '',
      lock: json['lock'] ?? '',
      lockMessage: json['lock_message'],
      systemId: json['system_id'] ?? 0,
      stageId: json['stage_id'] ?? 0,
      classroomId: json['classroom_id'] ?? 0,
      termId: json['term_id'] ?? 0,
      pathId: json['path_id'],
      institutionId: json['institution_id'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      system: SystemInfo(
        id: json['system']['id'] ?? 0,
        name: json['system']['name'] ?? '',
      ),
      stage: StageInfo(
        id: json['stage']['id'] ?? 0,
        name: json['stage']['name'] ?? '',
      ),
      classroom: ClassroomInfo(
        id: json['classroom']['id'] ?? 0,
        name: json['classroom']['name'] ?? '',
      ),
      term: TermInfo(
        id: json['term']['id'] ?? 0,
        name: json['term']['name'] ?? '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'is_vip': isVip,
      'references': references,
      'points': points,
      'attendance_weeks': attendanceWeeks,
      'phone': phone,
      'phone_verified': phoneVerified,
      'country_code': countryCode,
      'fake_number': fakeNumber,
      'type': type,
      'gendar': gendar,
      'mobile_id': mobileId,
      'mobile_type': mobileType,
      'img': img,
      'social_id': socialId,
      'username': username,
      'lock': lock,
      'lock_message': lockMessage,
      'system_id': systemId,
      'stage_id': stageId,
      'classroom_id': classroomId,
      'term_id': termId,
      'path_id': pathId,
      'institution_id': institutionId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'system': system.toJson(),
      'stage': stage.toJson(),
      'classroom': classroom.toJson(),
      'term': term.toJson(),
    };
  }
}
