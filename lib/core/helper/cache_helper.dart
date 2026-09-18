import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static const String _keyToken = 'user_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserName = 'user_name';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserPhone = 'user_phone';
  static const String _keyUserAddress = 'user_address';

  static const String _keyActiveBranchId = 'active_branch_id';
  static const String _keyActiveBranchName = 'active_branch';
  static const String _keyActiveBranchAddress = 'active_branch_address';
  static const String _keyActiveBranchShiftOpen = 'active_branch_shift_open';

  static Future<void> saveAuthData({
    required String token,
    required String refreshToken,
    required String userName,
    required String userEmail,
    String userId = '',
    String userPhone = '',
    String userAddress = '',
  }) async {
    await _preferences.setString(_keyToken, token);
    await _preferences.setString(_keyRefreshToken, refreshToken);
    await _preferences.setString(_keyUserName, userName);
    await _preferences.setString(_keyUserEmail, userEmail);
    await _preferences.setString(_keyUserId, userId);
    await _preferences.setString(_keyUserPhone, userPhone);
    await _preferences.setString(_keyUserAddress, userAddress);
  }


  static Future<void> saveActiveBranch({
    required int branchId,
    required String branchName,
    required String address,
    required bool isShiftOpen,
  }) async {
    await _preferences.setInt(_keyActiveBranchId, branchId);
    await _preferences.setString(_keyActiveBranchName, branchName);
    await _preferences.setString(_keyActiveBranchAddress, address);
    await _preferences.setBool(_keyActiveBranchShiftOpen, isShiftOpen);
  }

 // static int? getActiveBranchId() => _preferences.getInt(_keyActiveBranchId);
  static String? getActiveBranchName() => _preferences.getString(_keyActiveBranchName);
  static String? getActiveBranchAddress() => _preferences.getString(_keyActiveBranchAddress);
  static bool getActiveBranchShiftStatus() => _preferences.getBool(_keyActiveBranchShiftOpen) ?? false;

  // Generic String Setter/Getter
  static Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  static String? getString(String key) => _preferences.getString(key);

  // Auth Specific Getters
  static String? getToken() => _preferences.getString(_keyToken);
  static String? getRefreshToken() => _preferences.getString(_keyRefreshToken);
  static String? getUserId() => _preferences.getString(_keyUserId);
  static String? getUserName() => _preferences.getString(_keyUserName);
  static String? getUserEmail() => _preferences.getString(_keyUserEmail);
  static String? getUserPhone() => _preferences.getString(_keyUserPhone);
  static String? getUserAddress() => _preferences.getString(_keyUserAddress);

  static bool isLoggedIn() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  static Future<bool> clearSession() async {
    return await _preferences.clear();
  }

  static Future<void> updateUserData({
    required String userName,
    required String userEmail,
  }) async {
    await _preferences.setString(_keyUserName, userName);
    await _preferences.setString(_keyUserEmail, userEmail);
  }

  static int? getActiveBranchId() {
    final int? branchId = _preferences.getInt(_keyActiveBranchId);
    if (branchId == null || branchId <= 0) {
      return null;
    }
    return branchId;
  }


}