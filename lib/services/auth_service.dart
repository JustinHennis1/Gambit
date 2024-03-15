import 'package:gambit/services/adduser.dart';
import 'package:gambit/services/getrating.dart';
import 'package:gambit/services/getusername.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Extract the user's email
      String userEmail = authResult.user!.email ?? "";

      // Save the email to your database
      var tempuser = await getUsernameByEmail(userEmail);

      if (tempuser != null) {
        var myrate = await isRatingAvailable(tempuser);
        setValidationData(tempuser, userEmail, myrate);
      } else {
        //create username
        String newUsername = await createUsername();
        // then set validation data
        setValidationData(newUsername, userEmail, 1200);
        addNewUser(newUsername, userEmail);
      }
      return authResult;
    } catch (e) {
      print("Error signing in with Google: $e");
      // Handle error as needed
      rethrow; // Re-throw the exception after handling
    }
  }

  Future<String> createUsername() async {
    // Implement your logic to create a username, you can use a combination of user's info, random string, etc.
    // For example, you can use a combination of the user's display name and a random number
    String randomString =
        DateTime.now().millisecondsSinceEpoch.toRadixString(36).substring(2, 8);
    return "user_$randomString";
  }

  Future setValidationData(String username, String email, int rating) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('username', username);
    sharedPreferences.setString('email', email);
    sharedPreferences.setInt('rating', rating);
  }
}
