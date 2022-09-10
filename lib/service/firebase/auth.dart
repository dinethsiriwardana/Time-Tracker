import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Stream<User?> authStateChanges();
  Future<void> signOut();
  Future<void> deleteacc();
  Future<User?> signInAnonymously();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> createUserWithEmailandPassword(String email, String password);
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  //Stream Builder
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  // SignIn using Email
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final userCredential =
        await _firebaseAuth.signInWithCredential(EmailAuthProvider.credential(
      email: email,
      password: password,
    ));
    return userCredential.user;
  }

  @override
  Future<User?> createUserWithEmailandPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> deleteacc() async {
    await currentUser!.delete();
  }
}
