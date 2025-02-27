class MarketProductItemModel {
  String name;
  String unitOfMeasure;
  String price;
  String photo;
  String measurementValue;
  String description;
  String type;
  String id;
  int count;

  MarketProductItemModel(
      {required this.name,
      required this.measurementValue,
      required this.unitOfMeasure,
      required this.photo,
      required this.price,
      required this.description,
      required this.type,
      required this.id,
      required this.count});

  factory MarketProductItemModel.fromMap(Map<String, dynamic> map) {
    return MarketProductItemModel(
        name: map["name"],
        measurementValue: map["measurementValue"],
        unitOfMeasure: map["unitOfMeasure"],
        photo: map["photo"],
        price: map["price"],
        description: map["description"],
        type: map["type"],
        count: map["count"] ?? 0,
        id: map["id"]);
  }
}
