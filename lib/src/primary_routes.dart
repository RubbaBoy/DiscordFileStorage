import 'package:angular_router/angular_router.dart';

import 'login/login_component.template.dart' as login_component;
import 'files/files_component.template.dart' as files_component;

class Routes {
  static final login = RouteDefinition(
      routePath: RoutePaths.login,
      component: login_component.LoginComponentNgFactory,
      additionalData: {
        'showNav': false,
        'requireAuth': false
      }
  );

  static final files = RouteDefinition(
      routePath: RoutePaths.files,
      component: files_component.FilesComponentNgFactory
  );

  static final all = <RouteDefinition>[
    login,
    files
  ];
}

class RoutePaths {
  static final login = RoutePath(path: '/', useAsDefault: true);
  static final files = RoutePath(path: '/files');
}
