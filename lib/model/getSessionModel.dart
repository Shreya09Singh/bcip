import 'dart:convert';

class Getsessionmodel {
  final String id;
  final String name;
  final int age;
  final String gender;
  final int brainAge;
  final int score;
  final String phoneNumber;
  final List<Session> sessions;

  Getsessionmodel({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.brainAge,
    required this.score,
    required this.phoneNumber,
    required this.sessions,
  });

  factory Getsessionmodel.fromJson(Map<String, dynamic> json) {
    return Getsessionmodel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      brainAge: json['brainAge'],
      score: json['score'],
      phoneNumber: json['phoneNumber'],
      sessions: (json['sessions'] as List<dynamic>)
          .map((session) => Session.fromJson(session))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "age": age,
      "gender": gender,
      "brainAge": brainAge,
      "score": score,
      "phoneNumber": phoneNumber,
      "sessions": sessions.map((session) => session.toJson()).toList(),
    };
  }
}

class Session {
  final String sessionId;
  final String sessionName;
  final String userId;
  final int actualDuration;
  final int listenDuration;
  final int selectedThreshold;
  final List<int> focusValues;
  final List<int> overThresholdValues;
  final int overThresholdCount;

  Session({
    required this.sessionId,
    required this.sessionName,
    required this.userId,
    required this.actualDuration,
    required this.listenDuration,
    required this.selectedThreshold,
    required this.focusValues,
    required this.overThresholdValues,
    required this.overThresholdCount,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      sessionId: json['sessionId'],
      sessionName: json['sessionName'],
      userId: json['userId'],
      actualDuration: json['actualDuration'],
      listenDuration: json['listenDuration'],
      selectedThreshold: json['selectedThreshold'],
      focusValues: List<int>.from(json['focusValues']),
      overThresholdValues: List<int>.from(json['overThresholdValues']),
      overThresholdCount: json['overThresholdCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sessionId": sessionId,
      "sessionName": sessionName,
      "userId": userId,
      "actualDuration": actualDuration,
      "listenDuration": listenDuration,
      "selectedThreshold": selectedThreshold,
      "focusValues": focusValues,
      "overThresholdValues": overThresholdValues,
      "overThresholdCount": overThresholdCount,
    };
  }
}
