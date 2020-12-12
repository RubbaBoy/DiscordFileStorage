class FetchedFile {
  final String id;
  final String name;
  final String mime;
  final int size; // Size in bytes
  final int pieces; // Amount of file chunks
  final String thumbnail; // Thumbnail URL
  final String preview; // Full sized preview URL

  FetchedFile(this.id, this.name, this.mime, this.size, this.pieces, this.thumbnail, this.preview);

  FetchedFile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        mime = json['mime'],
        size = json['size'],
        pieces = json['pieces'],
        thumbnail = json['thumbnail'],
        preview = json['preview'];

  Map<String, dynamic> toJSON() => {
        'id': id,
        'name': name,
        'mime': mime,
        'size': size,
        'pieces': pieces,
        'thumbnail': thumbnail,
        'preview': preview,
      };
}
