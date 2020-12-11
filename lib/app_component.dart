import 'package:DiscordFileStorage/src/login/login_component.dart';
import 'package:DiscordFileStorage/src/primary_routes.dart';
import 'package:DiscordFileStorage/src/services/auth_service.dart';
import 'package:DiscordFileStorage/src/services/cookie_service.dart';
import 'package:DiscordFileStorage/src/services/nav_service.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'app-shit',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [
    routerDirectives,
    LoginComponent,
    NgIf
  ],
  providers: [
    ClassProvider(AuthService),
    ClassProvider(NavService),
    ClassProvider(CookieManager),
  ],
  exports: [Routes, RoutePaths],
)
class AppComponent {
  final Router _router;
  final CookieManager _cookieManager;
  final AuthService authService;

  @Input()
  bool showNav = true;

  AppComponent(this._router, this._cookieManager, this.authService) {
    _router.onRouteActivated.listen((state) {
      showNav = (state.routePath.additionalData ?? {})['showNav'] ?? true;

      var requireAuth = (state.routePath.additionalData ?? {})['requireAuth'] ?? true;
      if (requireAuth && (_cookieManager['username'] == null || _cookieManager['password'] == null)) {
        _router.navigate(Routes.login.toUrl());
      }
    });
  }

}
