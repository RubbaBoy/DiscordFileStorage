import 'dart:async';

import 'package:DiscordFileStorage/src/primary_routes.dart';
import 'package:DiscordFileStorage/src/services/auth_service.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'login',
  styleUrls: ['login_component.css'],
  templateUrl: 'login_component.html',
  directives: [

  ],
)
class LoginComponent implements OnInit {
  final Router _router;
  final AuthService authService;

  String username;
  String password;

  LoginComponent(this._router, this.authService);

  @override
  Future<Null> ngOnInit() async {

  }

  void continueCreds() {
    print('Logging in with $username $password');
    authService
      ..username = username
      ..password = password;

    _router.navigate(RoutePaths.files.path);
  }
}
