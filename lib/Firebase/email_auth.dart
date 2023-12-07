import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class EmailAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> createUser(
      {required String emailUser, required String pwdUser}) async {
    try {
      final credentials = await auth.createUserWithEmailAndPassword(
          email: emailUser, password: pwdUser);
      credentials.user!.sendEmailVerification();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> validateUser(
      {required String emailUser, required String pwdUser}) async {
    final credentials = await auth.signInWithEmailAndPassword(
        email: emailUser, password: pwdUser);
    if (credentials.user!.emailVerified) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signInWithGitHub() async {
    // Create a new provider
    GithubAuthProvider githubProvider = GithubAuthProvider();

    final credentials =
        await FirebaseAuth.instance.signInWithProvider(githubProvider);
    if (credentials.user!.emailVerified) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final credentials =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (credentials.user!.emailVerified) {
      return true;
    } else {
      return false;
    }
  }
}
