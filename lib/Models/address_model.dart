// ignore_for_file: public_member_api_docs, sort_constructors_first

class ShippingAddress {
  final String id;
  final String name;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final isDefault;

  ShippingAddress({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'address': address});
    result.addAll({'city': city});
    result.addAll({'state': state});
    result.addAll({'postalCode': postalCode});
    result.addAll({'country': country});
    result.addAll({'isDefault': isDefault});

    return result;
  }

  factory ShippingAddress.fromMap(Map<String, dynamic> map, documentId) {
    return ShippingAddress(
      id: documentId ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      postalCode: map['postalCode'] ?? '',
      country: map['country'] ?? '',
      isDefault: map['isDefault'] ?? false,
    );
  }

  ShippingAddress copyWith({
    String? id,
    String? name,
    String? address,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    bool? isDefault,
  }) {
    return ShippingAddress(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
