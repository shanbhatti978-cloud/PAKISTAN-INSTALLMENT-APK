import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  String? _role;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  String? get role => _role;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAdmin => _role == 'admin';
  bool get isStaff => _role == 'staff' || _role == 'admin';
  bool get isAuthenticated => _user != null;

  Future<void> init() async {
    _user = Supabase.instance.client.auth.currentUser;
    if (_user != null) await _loadRole();
    Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
      _user = data.session?.user;
      if (_user != null) {
        await _loadRole();
      } else {
        _role = null;
      }
      notifyListeners();
    });
  }

  Future<void> _loadRole() async {
    try {
      final res = await Supabase.instance.client
          .from('profiles')
          .select('role')
          .eq('id', _user!.id)
          .maybeSingle();
      _role = res?['role'] as String? ?? 'staff';
    } catch (_) {
      _role = 'staff';
    }
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final res = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      _user = res.user;
      await _loadRole();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
    _user = null;
    _role = null;
    notifyListeners();
  }
}
