import 'dart:async';
import 'dart:html';

import 'package:DiscordFileStorage/src/request_objects.dart';
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
  final ChangeDetectorRef changeRef;
  final streamSubscriptions = <StreamSubscription>[];
  final files = <FetchedFile>[
    FetchedFile('abc', 'something.png', 'image/png', 1234567, 1,
        'thumbnail.png', 'image.jpg')
  ];

  @Input()
  bool uploadHovering = false;

  @ViewChild('upload')
  FileUploadInputElement uploadElement;

  FilesComponent(this.authService, this.changeRef);

  @override
  Future<Null> ngOnInit() async {
    print(
        'In files with creds ${authService.username} ${authService.password}');

    Timer waiting;

    void startDrop(MouseEvent event) {
      event.preventDefault();
      event.stopPropagation();
      waiting?.cancel();
      if (!uploadHovering) {
        uploadHovering = true;
        changeRef.markForCheck();
      }
    }

    void stopDrop(MouseEvent event) {
      event.preventDefault();
      event.stopPropagation();
      waiting = Timer(Duration(milliseconds: 200), () {
        waiting = null;
        if (uploadHovering) {
          uploadHovering = false;
          changeRef.markForCheck();
        }
      });
    }

    uploadElement.onInput.listen((_) => uploadFormFile(uploadElement.files));

    streamSubscriptions.addAll([
      document.onKeyDown.listen((event) {
        // Escape
        if (event.key == 'Escape') {}
      }),
      document.onDragEnter.listen(startDrop),
      document.onDragOver.listen(startDrop),
      document.onDragLeave.listen(stopDrop),
      document.onDrop.listen((event) {
        stopDrop(event);
        uploadFormFile(event.dataTransfer.files);
      }),
    ]);
  }

  void uploadFormFile(List<File> files) {
    for (var file in files) {
      print('uploading ${file.name}');
    }
  }

  void uploadFile() => querySelector('#fileElem').click();

  String fileSize(int size) => size == null ? null : filesize(size);
}
