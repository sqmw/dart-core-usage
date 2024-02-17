import 'dart:io';
import 'dart:isolate';

Future<void> isolateFun(SendPort sendPort) async {
  print(1);
  sendPort.send('Msg from isolate');
  // await Future.delayed(const Duration(seconds: 3));
  sleep(const Duration(seconds: 3));
}

void main() async {
  ReceivePort receivePort = ReceivePort();
  SendPort sendPort = receivePort.sendPort;

  /// 可以知道 这里的 await 仅仅是等待 子 isolate 的创建结束，并不是执行完成
  Isolate isolate = await Isolate.spawn(
      isolateFun, sendPort); // sendPort 为 isolateFun 接收的那个参数
  print(2);
  receivePort.listen((message) {
    print(message);

    /// receivePort close 之后才能让 子 isolate 终止
    receivePort.close();
  }).onDone(() {
    /// 在receivePort.close();执行之后就会调用 onDone
    print('object');
    isolate.kill();
  });
}
