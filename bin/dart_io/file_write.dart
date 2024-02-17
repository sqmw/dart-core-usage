import 'dart:io';

void main() async {
  File fileByWrite = File('write.txt');
  if (await fileByWrite.exists() == false) {
    await fileByWrite.create();
    stderr.write('文件不存在，已经创建');
  }

  /// 表示的是覆盖写
  IOSink ioSink = fileByWrite.openWrite(mode: FileMode.write);
  ioSink.write('io_write');

  /// ioSink.add(List<int> data) # 用来写二进制文件
  await ioSink.flush();
  await ioSink.close();
  print('closed');


  sleep(const Duration(seconds: 10));
  return;
}