import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TokenNotifier extends StateNotifier<String>{
  TokenNotifier() : super("");

  void getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString("token");
    if(token==null)
      return;
    state = token;
  }
}

final tokenProvider = StateNotifierProvider<TokenNotifier, String>((ref) => TokenNotifier());