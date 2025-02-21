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
        data['kitchenName'] = doc.id;
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
        data['kitchenName'] = doc.id;
        kitchens.add(data);
      }
      StorageService.saveDataLocally(kitchens, StorageType.kitchens);
      return kitchens;
    } catch (e) {
      print("Error fetching markets: $e");
      return null;
    }
  }
}
