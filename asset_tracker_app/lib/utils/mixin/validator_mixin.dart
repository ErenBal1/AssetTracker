mixin ValidatorMixin {
  final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  //E-mail de olması gereken karakterleri RegExp ile belirttik.
  /// @ işaretinden sonra karakter ve . bulunması vb.

  String? checkEmail(String? text) {
    return text != null && text.isNotEmpty //text null ve ya boş değilse
        ? _emailRegex.hasMatch(text) // ve _emailRegex i barındırıyorsaq
            ? null
            : "Enter a valid email address"
        : "Please enter your email address";
  }

  String? checkPassword(String? text) {
    return text != null && text.isNotEmpty
        ? text.length > 6
            ? null
            : "Password must be at least 6 characters"
        : "Please enter your password";
  }

  /*
    if(text!=null && text.isNotEmpty){

      if(text.length>6){
        return null;
      }
      return "Password must be at lease 6 characters";
    }
    return "Please enter your password";
  */
}
