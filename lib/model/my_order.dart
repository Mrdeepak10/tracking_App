class MyOrder {
  String id;
  String phone;
  String address;
  String name;
  double amount;
  double latitude;
  double longitude;

  MyOrder({
    required this.id,
    required this.phone,
    required this.address,
    required this.name,
    required this.amount,
    required this.latitude,
    required this.longitude,
  });

  factory MyOrder.fromJson(Map<String, dynamic> json) {
    return MyOrder(
      id: json['id'],
      phone: json['phone'],
      address: json['address'],
      name: json['name'],
      amount: json['amount']?.toDouble(),
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'address': address,
      'name': name,
      'amount': amount,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
