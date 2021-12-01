import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_lab/Authenication/components/register.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../view/Dashboard/dashboard_view.dart';



AuthController authController = AuthController.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
GoogleSignIn googleSign = GoogleSignIn();

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  
  late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override
  void onReady() {
    super.onReady();
    // auth is comning from the constants.dart file but it is basically FirebaseAuth.instance. 
    // Since we have to use that many times I just made a constant file and declared there
    
    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);
      
      
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    
    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
        
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() =>  const Register());
        
    } else {
        
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => const DashboardPage());
        
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    // ignore: avoid_print
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() =>  const Register());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => const DashboardPage());
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth
            .signInWithCredential(credential)
            // ignore: invalid_return_type_for_catch_error, avoid_print
            .catchError((onErr) => print(onErr));
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      // ignore: avoid_print
      print(e.toString());
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);      
    // ignore: empty_catches
    } catch (firebaseAuthException) {}
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    // ignore: empty_catches
    } catch (firebaseAuthException) {}
  }

  void signOut() async {
    await auth.signOut();
  }
}