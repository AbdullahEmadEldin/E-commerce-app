// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserAddress {
  final String id;
  final String name;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  UserAddress(
      {required this.id,
      required this.name,
      required this.address,
      required this.city,
      required this.state,
      required this.postalCode,
      required this.country});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'address': address});
    result.addAll({'city': city});
    result.addAll({'state': state});
    result.addAll({'postalCode': postalCode});
    result.addAll({'country': country});

    return result;
  }

  factory UserAddress.fromMap(Map<String, dynamic> map, documentId) {
    return UserAddress(
      id: documentId ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      postalCode: map['postalCode'] ?? '',
      country: map['country'] ?? '',
    );
  }
}
