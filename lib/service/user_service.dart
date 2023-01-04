import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<UserData?> getUser() {
    return _firestore
        .collection('users')
        .doc('CaGwjki1V61AXEQw40Gj')
        .snapshots()
        .map((event) => _userData(event));
  }

  UserData? _userData(DocumentSnapshot docs) {
    final xxx = docs.data() as Map<String, dynamic>;
    return UserData.fromMap(xxx);
  }
}

class UserData {
  final String? name;
  final bool isPremiumUser;
  final int total;
  UserData({
    this.name,
    required this.isPremiumUser,
    required this.total,
  });

  UserData copyWith({
    String? name,
    bool? isPremiumUser,
    int? total,
  }) {
    return UserData(
      name: name ?? this.name,
      isPremiumUser: isPremiumUser ?? this.isPremiumUser,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isPremiumUser': isPremiumUser,
      'total': total,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'],
      isPremiumUser: map['isPremiumUser'] ?? false,
      total: map['total'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserData(name: $name, isPremiumUser: $isPremiumUser, total: $total)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.name == name &&
        other.isPremiumUser == isPremiumUser &&
        other.total == total;
  }

  @override
  int get hashCode => name.hashCode ^ isPremiumUser.hashCode ^ total.hashCode;
}
