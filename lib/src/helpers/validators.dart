class Validators {
  static isNull(val) {
    return val == null || val.trim() == '';
  }

  static required(key, val) {
    return isNull(val) ? key + ' wajib di isi' : null;
  }

  static String validateEmailString(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Email Tidak Valid';
    else
      return null;
  }
}
