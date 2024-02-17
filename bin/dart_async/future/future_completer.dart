import 'dart:async';

void main() {
  // 创建Completer
  Completer<String> completer = Completer();

  // 模拟异步操作
  Future.delayed(Duration(seconds: 2), () {
    /// 异步操作完成时调用complete方法
    /// 在Dart中，Completer的complete方法执行完成后，相关的Future回调通常会被放入微任务队列中。
    completer.complete("Operation completed successfully");
  });

  // 获取Future
  Future<String> myFuture = completer.future;

  // 等待异步操作完成并处理结果
  myFuture.then((result) {
    print(result);
  });
}
