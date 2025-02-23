class MarketProductItemModel {
  String name;
  String unitOfMeasure;
  String price;
  String photo;
  String measurementValue;
  String description;

  MarketProductItemModel(
      {required this.name,
      required this.measurementValue,
      required this.unitOfMeasure,
      required this.photo,
      required this.price,
      required this.description});

  factory MarketProductItemModel.fromMap(Map<String, dynamic> map) {
    return MarketProductItemModel(
        name: map["name"],
        measurementValue: map["measurementValue"],
        unitOfMeasure: map["unitOfMeasure"],
        photo: map["photo"],
        price: map["price"],
        description: map["description"]);
  }
}
