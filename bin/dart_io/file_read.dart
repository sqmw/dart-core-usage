import 'dart:convert';
import 'dart:io';

void main() async {
  File fileByRead = File("write.txt");
  if (!await fileByRead.exists()) {
    fileByRead.createSync();
    stderr.write("该文件不存在，已创建");
  }

  /// 使用流的方式读取
  Stream<List<int>> inputStream = fileByRead.openRead();

  /// 1. Stream<List<int>> 绑定到 utf8 解码器上面得到对应的 Stream<String>
  /// 2. 将得到的 Stream<String> 通过 Stream 的方法 transform 在行分割器下面进行分割
  /// 这样实现了边读边处理
  Stream<String> lines =
  (utf8.decoder.bind(inputStream)).transform(const LineSplitter());
  var t1 = 0;
  try {
    await for (final _ in lines) {
      print('t1 ${t1++}');
    }
    print('file is now closed');
  } catch (e) {
    print(e);
  }


  Stream<List<int>> inputStream2 = fileByRead.openRead();
  var t2 = 0;
  /// stream等的操作只要没有 async 和 await 关键字就是异步的
  inputStream2.listen((data) { // 每次输入缓冲区满了就会被监听到
    print('t2: ${t2++}');
  });

  print('${t1}, ${t2}');
}