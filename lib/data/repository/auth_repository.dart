import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final Stream<User?> userStream = FirebaseAuth.instance.userChanges();
  ConfirmationResult? _confirmationResult;
  String? verificationId;

  Future<void> sendSMS({required String number}) async {
    try {
      _confirmationResult =
          await FirebaseAuth.instance.signInWithPhoneNumber(number);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> sendSMSForMobile({required String number}) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        codeSent: (verificationId, forceResendingToken) {
          this.verificationId = verificationId;
        },
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> verifySMSCodeForMobile({required String code}) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId ?? '',
        smsCode: code,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.credential != null;
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> verifySMSCode({required String code}) async {
    try {
      final result = await _confirmationResult?.confirm(code);

      return result?.credential != null;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {
      rethrow;
    }
  }
}
