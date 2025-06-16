import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireauthService {
  GoogleSignInAccount? _googleUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  factory FireauthService() => FireauthService._internal();

  FireauthService._internal();

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    _googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await _googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOutFromFireAuth() async {
    // Clear Firebase auth session

    await FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
  }
}
