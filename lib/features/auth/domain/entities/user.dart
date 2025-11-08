class User {
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
  final String token;
  final SystemInfo system;
  final StageInfo stage;
  final ClassroomInfo classroom;
  final TermInfo term;

  const User({
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
    required this.token,
    required this.system,
    required this.stage,
    required this.classroom,
    required this.term,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.isVip == isVip &&
        other.references == references &&
        other.points == points &&
        other.attendanceWeeks == attendanceWeeks &&
        other.phone == phone &&
        other.phoneVerified == phoneVerified &&
        other.countryCode == countryCode &&
        other.fakeNumber == fakeNumber &&
        other.type == type &&
        other.gendar == gendar &&
        other.mobileId == mobileId &&
        other.mobileType == mobileType &&
        other.img == img &&
        other.socialId == socialId &&
        other.username == username &&
        other.lock == lock &&
        other.lockMessage == lockMessage &&
        other.systemId == systemId &&
        other.stageId == stageId &&
        other.classroomId == classroomId &&
        other.termId == termId &&
        other.pathId == pathId &&
        other.institutionId == institutionId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.token == token &&
        other.system == system &&
        other.stage == stage &&
        other.classroom == classroom &&
        other.term == term;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        isVip.hashCode ^
        references.hashCode ^
        points.hashCode ^
        attendanceWeeks.hashCode ^
        phone.hashCode ^
        phoneVerified.hashCode ^
        countryCode.hashCode ^
        fakeNumber.hashCode ^
        type.hashCode ^
        gendar.hashCode ^
        mobileId.hashCode ^
        mobileType.hashCode ^
        img.hashCode ^
        socialId.hashCode ^
        username.hashCode ^
        lock.hashCode ^
        lockMessage.hashCode ^
        systemId.hashCode ^
        stageId.hashCode ^
        classroomId.hashCode ^
        termId.hashCode ^
        pathId.hashCode ^
        institutionId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        token.hashCode ^
        system.hashCode ^
        stage.hashCode ^
        classroom.hashCode ^
        term.hashCode;
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phone: $phone, type: $type, token: $token)';
  }
}

class SystemInfo {
  final int id;
  final String name;

  const SystemInfo({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SystemInfo && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() => 'SystemInfo(id: $id, name: $name)';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class StageInfo {
  final int id;
  final String name;

  const StageInfo({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StageInfo && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() => 'StageInfo(id: $id, name: $name)';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class ClassroomInfo {
  final int id;
  final String name;

  const ClassroomInfo({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ClassroomInfo && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() => 'ClassroomInfo(id: $id, name: $name)';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class TermInfo {
  final int id;
  final String name;

  const TermInfo({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TermInfo && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() => 'TermInfo(id: $id, name: $name)';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}