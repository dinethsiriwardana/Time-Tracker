import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/service/firebase/database.dart';

abstract class AuthBase {
  Stream<User?> authStateChanges();
  Future<void> signOut(context);
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

  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    // print("Logged As user ${userCredential.user.uid}");
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
  Future<void> signOut(context) async {
    final database = Provider.of<Database>(context, listen: false);

    if (currentUser!.isAnonymous) {
      print("Anonymous Account Detected and Delete IT");
      await database.deleteaccount();
      await currentUser!.delete();
    }
    await _firebaseAuth.signOut();
    _firebaseAuth.authStateChanges();
  }

  @override
  Future<void> deleteacc() async {
    await currentUser!.delete();
  }
}
