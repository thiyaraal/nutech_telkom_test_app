

class ApiURL {
  static const String url = 'https://take-home-test-api.nutech-integrasi.com';
  // register
  static const String register = '$url/registration';
  // login
  static const String login = '$url/login';
  // get profile
  static const String profile = '$url/profile';
  //update profile
  static const String editProfile = '$url/profile/update';
  // edit profile
  static const String deleteProfile = '$url/profile/image';

  /// module information
  static const String banner = '$url/banner';
  // layanan
  static const String service = '$url/services';

  //module transaction
  //// saldo
  static const String saldo = '$url/balance';
  // top up
  static const String topUp = '$url/topup';
  // transaction
  static const String transaction = '$url/transaction';
  // history transaction
  static const String historyTransaction = '$url/transaction/history';
}
