//simdilik baglamıyorum sadece uygulama icerisindeki constant stringlerimi buraya yazıyorum.

class LocalStrings {
  //onBoard view Screens
//1
  static const trackAssetsTitle = 'Track Your Assets';
  static const trackAssetsDescription =
      'Easily manage and track all your assets in one place';

//2
  static const realTimeTitle = 'Real-time Display';
  static const realTimeDescription =
      'View the status of your assets and how much profit or loss you have made';

//3
  static const analyticsTitle = 'Detailed Analytics';
  static const analyticsDescription =
      'View comprehensive reports and analytics';

//onBoard view button
  static const getStartedButton = 'Get Started';
  static const nextButton = 'Next';

//login screen
  static const enterPassword = 'Please enter your password';
  static const atLeast6characters = 'Password must be at least 6 characters';
  static const passwordLabel = 'Password';
  static const enterEmail = 'Please enter your email address.';
  static const enterValidEmail = 'Enter a valid email address.';
  static const emailLabel = 'Email';
  static const welcome = 'Welcome';
  static const signIn = 'Sign In';

  //splash screen
  static const appLabel = 'Asset Tracker';

  //firebase errors
  static const userNotFound = 'No users registered with this email.';
  static const wrongPassword = 'You entered an incorrect password.';
  static const userDisabled = 'This account has been deactivated.';
  static const invalidEmail = 'Invalid email address.';
  static const invalidCredential = 'Email or password incorrect.';
  static const tooManyRequests =
      'You have made too many failed login attempts. Please try again later.';
  static const defaultError = 'An error occurred: ';
  static const loginError = 'There was an error logging in. Please try again.';
  static const weakPassword =
      'The password is too weak. Use at least 6 characters.';
  static const emailAlreadyinUse = 'This email address is already in use.';
  static const operationNotAllowed = 'Email/password login is not active.';
}
