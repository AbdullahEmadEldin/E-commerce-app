class UserData {
  final String uId;
  final String email;
  final String name;

  UserData({required this.uId, required this.email, required this.name});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'uId': uId});
    result.addAll({'email': email});
    result.addAll({'name': name});
    return result;
  }

  factory UserData.fromMap(Map<String, dynamic> map, String documentId) {
    return UserData(
      uId: documentId,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
