import 'dart:io';

void main() async {
  Directory directory = Directory('F:\\language');
  if (directory.existsSync()) {
    /// directory.list() // 返回一个 Stream<FileSystemEntity>
    List<FileSystemEntity> fFileList = directory.listSync(recursive: true);
    print(fFileList.length);
  }
}