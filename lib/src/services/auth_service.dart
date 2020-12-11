
import 'package:DiscordFileStorage/src/services/cookie_service.dart';
import 'package:angular/core.dart';

@Injectable()
class AuthService {
  String _username;
  String _password;

  String get username => _username ?? _cookieManager['username'];
  set username(value) {
    _username = value;
    _cookieManager['username'] = value;
  }

  String get password {
    var bruh = _password ?? _cookieManager['password'];
    print('retting pass $bruh (vookie ver is ${_cookieManager['password']})');
    return bruh;
  }
  set password(value) {
    _password = value;
    _cookieManager['password'] = value;
  }

  final CookieManager _cookieManager;

  AuthService(this._cookieManager);

}
