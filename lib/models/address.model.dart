class AddressModel {
  String? id;
  late String mainText;
  late String description;
  late String postalCode;
  late double latitude;
  late double longitude;

  AddressModel({
    required this.description,
    this.mainText = "",
    this.postalCode = "",
    this.id,
    this.latitude = 0,
    this.longitude = 0,
  });
}
