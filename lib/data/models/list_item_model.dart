class ListItemModel {
  final String name;
  final String photo;
  final String rating;
  final String reviewsCount;
  final String minOrder;
  final String minDeliveryTime;
  final String maxDeliveryTime;
  final String deliveryPrice;
  final String deliveryPriceAfterFree;
  final String type;
  final String id;

  ListItemModel(
      {required this.name,
      required this.photo,
      required this.rating,
      required this.reviewsCount,
      required this.minOrder,
      required this.minDeliveryTime,
      required this.maxDeliveryTime,
      required this.deliveryPrice,
      required this.deliveryPriceAfterFree,
      required this.type,
      required this.id});

  factory ListItemModel.fromMap(Map<String, dynamic> map) {
    return ListItemModel(
        name: map['name'],
        photo: map['photo'],
        rating: map['rating'],
        reviewsCount: map['reviewsCount'],
        minOrder: map['minOrder'],
        minDeliveryTime: map['minDeliveryTime'],
        maxDeliveryTime: map['maxDeliveryTime'],
        deliveryPrice: map['deliveryPrice'],
        deliveryPriceAfterFree: map['deliveryPriceAfterFree'],
        type: map['type'] ?? '',
        id: map['id']);
  }
}
