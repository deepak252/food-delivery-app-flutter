
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/utils/logger.dart';
import 'package:food_delivery_app/widgets/custom_snackbar.dart';

class FirebaseAuthService{
  static final _logger = Logger("FirebaseAuthService");
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  static Future<User> signUp({required String email,required String password})async {
    String error = "Something went wrong!";
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(result.user==null){
        throw error;
      }
      return result.user!;
    } catch (e,s) {
      _logger.error("signUp",error: e,stackTrace: s);
      if(e.runtimeType==FirebaseAuthException){
        error = emailAuthException(e as FirebaseAuthException);
      }
    }
    throw error;
  }

  static Future<UserCredential> signIn({required String email,required String password})async {
    String error = "Something went wrong!";
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } catch (e,s) {
      _logger.error("signIn",error: e,stackTrace: s);
      if(e.runtimeType==FirebaseAuthException){
        error = emailAuthException(e as FirebaseAuthException);
      }
    }
    throw error;
  }

  // static Future<bool> resetPassword({required BuildContext context, required String email})async{
  //   try {
  //     await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  //     log("Password reset link sent to $email");
  //     customSnackBar(text: "Password reset link sent to $email", context: context, color: Colors.green[700]);
  //     return true;
  //   } on FirebaseAuthException catch (e) {
  //     log('resetPassword error : $e');
  //     customSnackBar(text: emailAuthException(e), context: context, color: Colors.red[400]);
  //     return false;
  //   }
  // }

  static Future signOut()async{
    try {
      await _firebaseAuth.signOut();
      _logger.message("signOut", "Signout Successful");
    } catch (e,s) {
      _logger.error("logout",error: e,stackTrace: s);
    }
  }


  static String emailAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'User does not exist with this email';
      case 'wrong-password':
        return 'Invalid e-mail/password';
      case 'invalid-email':
        return 'Enter a valid e-mail';
      case 'email-already-in-use':
        return 'User already exist with this email';   
      case 'weak-password': 
        return 'Password entered is too weak.';

      default:
        return 'Something went wrong';
    }
  }
  
}
