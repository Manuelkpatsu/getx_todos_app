import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> onAuthChanged() {
    return _firebaseAuth.authStateChanges();
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    return await _googleSignIn.signIn();
  }

  Future<UserCredential> signInWithCredential({
    required AuthCredential credential,
  }) async {
    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<UserCredential> signUp(
      {required String email, required String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<String> getAccessToken() async {
    User? user = await getCurrentUser();
    return await user!.getIdToken();
  }

  Future<String> getRefreshToken() async {
    User? user = await getCurrentUser();
    return await user!.getIdToken(true);
  }

  Future<void> signOut() async {
    Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<void> sendEmailVerification() async {
    User? user = await getCurrentUser();
    return await user!.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User? user = await getCurrentUser();
    return user!.emailVerified;
  }

  Future<void> changeEmail({required String email}) async {
    User? user = await getCurrentUser();
    return await user!.updateEmail(email);
  }

  Future<void> changePassword({required String password}) async {
    User? user = await getCurrentUser();
    return await user!.updatePassword(password);
  }

  Future<void> deleteUser() async {
    User? user = await getCurrentUser();
    return await user!.delete();
  }

  Future<void> sendPasswordResetMail({required String email}) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
