import 'dart:async';

Future<void> main() async {
  Completer<String> completer = Completer<String>();
  Future future = Future.delayed(const Duration(seconds: 2), () {
    /// 这里的 completer 将会创建一个新的新的 Future，并且放入MicroTask Queue里面
    completer.complete('finish');
  });

  /// 得到的两个 id 不一样
  print('future id: ${identityHashCode(future)}');
  print('completer.future id: ${identityHashCode(completer.future)}');

  print(await completer.future);
}
