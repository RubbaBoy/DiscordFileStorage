import 'dart:async';

import 'package:DiscordFileStorage/src/services/auth_service.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'files',
  styleUrls: ['files_component.css'],
  templateUrl: 'files_component.html',
  directives: [
    NgFor
  ],
)
class FilesComponent implements OnInit {
  final AuthService authService;
  final files = ['1', '2', '3', '4', '5', '6', '7', '8'];

  FilesComponent(this.authService);

  @override
  Future<Null> ngOnInit() async {
    print('In files with creds ${authService.username} ${authService.password}');
  }
}
