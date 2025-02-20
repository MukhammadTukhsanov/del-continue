import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseDatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _fStorage = FirebaseStorage.instance;

  Future<List<Map<String, dynamic>>?> fetchMarkets() async {
    try {
      CollectionReference marketsRef = _firestore.collection("markets");
      QuerySnapshot marketsSnapshot = await marketsRef.get();

      List<Map<String, dynamic>> markets = marketsSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return markets;
    } catch (e) {
      print("Error fetching markets: $e");
      return null;
    }
  }
}
