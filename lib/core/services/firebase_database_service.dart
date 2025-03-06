import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';

class FirebaseDatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _fStorage = FirebaseStorage.instance;

  Future<List<Map<String, dynamic>>?> fetchMarkets() async {
    const defaultImageUrl =
        'https://firebasestorage.googleapis.com/v0/b/yo-lda-a732c.appspot.com/o/qassob.png?alt=media&token=1a123d6f-0af6-476b-8ab2-eac16c5f77ad'; // Move to config or env variable
    try {
      CollectionReference marketsRef = _firestore.collection("markets");
      QuerySnapshot marketsSnapshot = await marketsRef.get();

      List<Map<String, dynamic>> markets = [];

      for (var doc in marketsSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String? imagePath = data['photo'] as String?;

        try {
          if (imagePath != null && imagePath.isNotEmpty) {
            String imageUrl = await _fStorage.ref(imagePath).getDownloadURL();
            data['photo'] = imageUrl;
          } else {
            data['photo'] = defaultImageUrl;
          }
        } on FirebaseException catch (e) {
          print('🔥 Firebase Storage Error for $imagePath: ${e.message}');
          data['photo'] = defaultImageUrl;
        }
        data['id'] = doc.id;
        markets.add(data);
      }
      StorageService.saveDataLocally(markets, StorageType.markets);
      return markets;
    } catch (e) {
      print("Error fetching markets: $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> fetchKitchens() async {
    const defaultImageUrl =
        'https://firebasestorage.googleapis.com/v0/b/yo-lda-a732c.appspot.com/o/qassob.png?alt=media&token=1a123d6f-0af6-476b-8ab2-eac16c5f77ad'; // Move to config or env variable
    try {
      CollectionReference kitchensRef = _firestore.collection("kitchens");
      QuerySnapshot kitchensSnapshot = await kitchensRef.get();

      List<Map<String, dynamic>> kitchens = [];

      for (var doc in kitchensSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String? imagePath = data['photo'] as String?;

        try {
          if (imagePath != null && imagePath.isNotEmpty) {
            String imageUrl = await _fStorage.ref(imagePath).getDownloadURL();
            data['photo'] = imageUrl;
          } else {
            data['photo'] = defaultImageUrl;
          }
        } on FirebaseException catch (e) {
          print('🔥 Firebase Storage Error for $imagePath: ${e.message}');
          data['photo'] = defaultImageUrl;
        }
        data['id'] = doc.id;
        kitchens.add(data);
      }
      StorageService.saveDataLocally(kitchens, StorageType.kitchens);
      return kitchens;
    } catch (e) {
      print("Error fetching markets: $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> fetchSingleMarket(
      String id, String type) async {
    List<Map<String, dynamic>> markets = [];
    try {
      CollectionReference singleMarketRef =
          _firestore.collection(type).doc(id).collection("products");
      QuerySnapshot singleMarketSnapshot = await singleMarketRef.get();
      for (var doc in singleMarketSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String photo = await _fStorage.ref(data["photo"]).getDownloadURL();
        data["photo"] = photo;
        data["count"] = 0;
        markets.add(data);
        print("data: $data");
      }
      print("markets: $markets");
      return markets;
    } catch (e) {
      print("Error fetching single market: $e");
    }
    return null;
  }

  Future<void> sendOrder(List<dynamic> data, String id, bool isDeliveryFree,
      String deliveryPrice, int totalPrice) async {
    try {
      await _firestore.collection("markets").doc(id).collection("orders").add({
        "items": data,
        "totalPrice": totalPrice,
        "deliveryPrice": isDeliveryFree ? "free" : deliveryPrice,
        "createdAt": FieldValue.serverTimestamp(),
      });

      print("Order sent successfully");
    } catch (e) {
      print("Error sending order: $e");
    }
  }

  Future<void> fetchUserInfo(String email) async {
    String phoneNumber = email.split('@').first;
    try {
      DocumentReference userRef =
          _firestore.collection("users").doc(phoneNumber);
      DocumentSnapshot userSnapshot = await userRef.get();

      if (userSnapshot.exists) {
        print("User Data: ${userSnapshot.data()}");
        List<Map<String, dynamic>> userDataList = [
          userSnapshot.data() as Map<String, dynamic>
        ];
        StorageService.saveDataLocally(userDataList, StorageType.userInfo);
      } else
        print("User not found");
    } catch (e) {
      print("Error: $e");
    }
  }
}
