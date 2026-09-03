import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static const String _keyToken = 'user_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserName = 'user_name';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserPhone = 'user_phone';
  static const String _keyUserAddress = 'user_address';
 // static const String _keyUserImage = 'user_image';
 // static const String _keyUserType = 'user_type';

  static Future<void> saveAuthData({
    required String token,
    required String userId,
    required String userName,
    required String userEmail,
    required String userPhone,
    required String userAddress,
    // String? userImage,
    // required String userType,
  }) async {
    await _preferences.setString(_keyToken, token);
    await _preferences.setString(_keyUserId, userId);
    await _preferences.setString(_keyUserName, userName);
    await _preferences.setString(_keyUserEmail, userEmail);
    await _preferences.setString(_keyUserPhone, userPhone);
    await _preferences.setString(_keyUserAddress, userAddress);
    // await _preferences.setString(_keyUserType, userType);
    // if (userImage != null) {
    //   await _preferences.setString(_keyUserImage, userImage);
    // }
  }

  static String? getToken() => _preferences.getString(_keyToken);
  static String? getUserId() => _preferences.getString(_keyUserId);
  static String? getUserName() => _preferences.getString(_keyUserName);
  static String? getUserEmail() => _preferences.getString(_keyUserEmail);
  static String? getUserPhone() => _preferences.getString(_keyUserPhone);
  static String? getUserAddress() => _preferences.getString(_keyUserAddress);

  // static String? getUserImage() => _preferences.getString(_keyUserImage);
  // static String? getUserType() => _preferences.getString(_keyUserType);

  static bool isLoggedIn() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  static Future<bool> clearSession() async {
    return await _preferences.clear();
  }

  // static Future<void> updateUserData({
  //   required String userName,
  //   required String userEmail,
  // }) async {
  //   await _preferences.setString(_keyUserName, userName);
  //   await _preferences.setString(_keyUserEmail, userEmail);
  // }
}