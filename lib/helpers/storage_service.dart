import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();

  factory StorageService() {
    return _instance;
  }

  StorageService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  final String _score = "score";

  Future<void> saveScore(int score) async {
    await _prefs?.setInt(_score, score);
  }

  Future<int> getScore() async {
    int? score = _prefs?.getInt(_score);
    if(score == null) {
      return 0;
    }
    return score;
  }
}