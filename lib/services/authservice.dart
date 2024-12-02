import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      // Sign out any previously signed-in Google account to force the account picker
      await _googleSignIn.signOut();

      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

      if (gUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Obtain the Google sign-in authentication
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential for Firebase authentication
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Authenticate with Firebase and return the signed-in user
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null; // Return null in case of an error
    }
  }
}
