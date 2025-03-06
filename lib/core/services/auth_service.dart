import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geo_scraper_mobile/core/services/storage_service.dart';
import 'package:http/http.dart' as http;

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  Future<String?> registration(
      String email, String password, String username, String surname) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: "$email@example.com",
        password: password,
      );

      String userId = userCredential.user?.uid ?? ""; // Use UID as doc ID

      await _firebaseFirestore.collection('users').doc(userId).set({
        'username': username,
        'surname': surname,
        'phoneNumber':
            email, // If this is actually a phone number, change the param name
      });

      return null; // No error, registration successful
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "Bu raqam allaqachon ro‘yxatdan o‘tgan."; // Return error message
      } else {
        return "Ro‘yxatdan o‘tishda xatolik: ${e.message}";
      }
    } catch (e) {
      return "Noma’lum xatolik: $e"; // Unexpected errors
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: "$email@example.com",
        password: password,
      );

      return null; // Успешный вход, без ошибки
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Bu raqam tizimda mavjud emas."; // Пользователь не найден
      } else if (e.code == 'wrong-password') {
        return "Noto‘g‘ri parol."; // Неверный пароль
      } else {
        print(e.message);
        return "Login yoki parol xato!";
      }
    } catch (e) {
      return "Noma’lum xatolik: $e"; // Другие ошибки
    }
  }

  String verificationId = '';

  Future<void> sendOTP(String phoneNumber) async {
    String otp =
        (100000 + (DateTime.now().millisecondsSinceEpoch % 900000)).toString();

    String apiKey = "cfabbae1";
    String apiSecret = "iBpfJ2E9vOJD7BWl";

    String url =
        "https://rest.nexmo.com/sms/json?api_key=$apiKey&api_secret=$apiSecret&to=$phoneNumber&from=Vonage&text=Your+OTP+code+is+$otp";

    var response = await http.get(Uri.parse(url));

    print("OTP sent: $otp, Response: ${response.body}");
  }

  Future<void> verifyAndLinkPhoneNumber(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      User? user = _auth.currentUser;
      if (user != null) {
        await user.linkWithCredential(credential);
        print("Phone number linked successfully!");
      } else {
        print("User not logged in");
      }
    } catch (e) {
      print("Error linking phone number: $e");
    }
  }

  Future<UserCredential?> logout() async {
    try {
      await _auth.signOut();
      await StorageService.removeDataFtomLocal(StorageType.userInfo);
    } catch (e) {
      print("Error on Logouting");
    }
    return null;
  }
}
