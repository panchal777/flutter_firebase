
abstract class AuthenticationRepo {
  /* sign up */
  Future<bool> signUpWithEmailAndPassword(String email, String password);

  /*sign in with email and password */
  Future<bool> loginWithEmailAndPassword(String email, String password);

  /*sign in with mobile */
  Future<dynamic> loginInWithMobile(String mobile);

  Future<dynamic> verifyOtpForSignIn(String verifyId, String otp);

  /* forgot password */
  Future<dynamic> forgotPassword(String email);

  /* change password */
  Future<dynamic> changePassword(String email, String password);
}
