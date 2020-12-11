import 'dart:async';

import 'package:DiscordFileStorage/src/file.dart';
import 'package:DiscordFileStorage/src/services/auth_service.dart';
import 'package:angular/angular.dart';
import 'package:filesize/filesize.dart';

@Component(
  selector: 'files',
  styleUrls: ['files_component.css'],
  templateUrl: 'files_component.html',
  directives: [
    NgFor,
    NgIf,
  ],
)
class FilesComponent implements OnInit {
  final AuthService authService;
  final files = <File>[File('abc', 'something.png', 'image/png', 1234567, 1, 'thumbnail.png', 'image.jpg')];

  FilesComponent(this.authService);

  @override
  Future<Null> ngOnInit() async {
    print('In files with creds ${authService.username} ${authService.password}');
  }

  String fileSize(int size) => size == null ? null : filesize(size);
}
