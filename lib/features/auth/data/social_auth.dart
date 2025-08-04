import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialAuth {
  // Google Login
  static Future<({UserCredential? userCredential, String? accessToken})>
      loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // if googleUser is null, return null
      if (googleUser == null) {
        return (userCredential: null, accessToken: null);
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return (
        userCredential: userCredential,
        accessToken: googleAuth.accessToken
      );
    } on Exception catch (e) {
      debugPrint('exception: $e');
    }
    return (userCredential: null, accessToken: null);
  }

  // // Google Logout
  // static Future<bool> logoutWithGoogle(
  //     {required SocialAuthType socialAuthType}) async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     switch (socialAuthType) {
  //       case SocialAuthType.google:
  //         await GoogleSignIn().signOut();
  //         break;
  //       case SocialAuthType.facebook:
  //         await FacebookAuth.instance.logOut();
  //         break;
  //       case SocialAuthType.apple:
  //         // await SignInWithApple().;
  //         break;
  //     }
  //     return true;
  //   } on Exception catch (e) {
  //     debugPrint('exception: $e');
  //     return false;
  //   }
  // }

  // logout from all social media by one function
  static Future<bool> logoutFromAllSocialMedia() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
      return true;
    } on Exception catch (e) {
      debugPrint('exception: $e');
      return false;
    }
  }

  // Facebook Login
  static Future<(Map<String, dynamic>? userData, String? accessToken)>
      loginWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile']);

    try {
      if (loginResult.status == LoginStatus.success) {
        final userCredential = await FacebookAuth.instance.getUserData(
          fields: "name,email,picture.width(200)",
        );

        return (userCredential, loginResult.accessToken!.tokenString);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
    return (null, null);
  }

  // Apple Login
  static Future<(UserCredential? userCredential, String? accessToken)>
      loginWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Check if identityToken or authorizationCode is null
      if (credential.identityToken == null) {
        debugPrint('Apple Sign In returned null tokens');
        return (null, null);
      }

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      return (userCredential, credential.authorizationCode);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        debugPrint('User canceled the Apple sign-in');
        return (null, null);
      } else {
        rethrow;
      }
    }
  }
}

enum SocialAuthType {
  google,
  facebook,
  apple,
}
