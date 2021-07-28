class AddressModel {
  late String street;
  late String number;
  late String city;
  late String postalCode;
  late String district;
  late double latitude;
  late double longitude;

  AddressModel({
    required this.street,
    required this.number,
    required this.city,
    required this.postalCode,
    required this.district,
    this.latitude = 0,
    this.longitude = 0,
  });

  AddressModel.fromMap(Map<String, dynamic> model) {
    this.city = model["administrativeArea"];
    this.postalCode = model["postalCode"];
    this.district = model["subLocality"];
    this.street = model["thoroughfare"];
    this.number = model["subThoroughfare"];
    this.latitude = model["latitude"];
    this.longitude = model["logitude"];
  }
}
