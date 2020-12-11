import 'dart:html';

import 'package:angular/angular.dart';

@Injectable()
class CookieManager {

  @override
  operator []=(String key, String value) => document.cookie = '$key=$value;';

  @override
  String operator [](String key) => document.cookie
      .split(';')
      .map((e) => e.split('='))
      .firstWhere((kv) => kv[0].trim() == key, orElse: () => [null, null])[1];
}
