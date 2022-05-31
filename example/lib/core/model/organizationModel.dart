import 'package:shared_preferences/shared_preferences.dart';

class OrganizationModel {
  String? _name;
  String? _avatarUrl;
  bool _isFav = false;

  String? get name => _name;
  String? get avatartUrl => _avatarUrl;
  bool get isFav => _isFav;

  OrganizationModel.fromJson(Map json) {
    _name = json["login"];
    _avatarUrl = json["avatar_url"];
  }

  void toggleIsFav() async {
    _isFav = !_isFav;
    final _preferences = await SharedPreferences.getInstance();
    bool _hasKey = _preferences.containsKey(_name!);
    if (_hasKey && _isFav == false) {
      await _preferences.remove(_name!);
    } else if (_hasKey == false && _isFav) {
      await _preferences.setString(
          _name!, "{login: $_name, avatar_url: $_avatarUrl}");
    }
  }

  void setIsFav(bool value) {
    _isFav = value;
  }
}
