import 'dart:async';

/// 并非所有情况都要手动关闭 StreamController。
/// 在某些情况下，例如在使用 async* 生成器函数创建的 Stream 中，Dart 会在生成器完成时自动关闭流。
/// 但在其他情况下，尤其是在手动添加事件到流中的情况下，手动关闭是个好的实践。

void main() async {
  /// 创建一个 StreamController.broadcast
  var controller = StreamController<int>.broadcast();

  // 获取 Stream
  var stream = controller.stream;

  // 监听 Stream 1
  var subscription1 = stream.listen((data) {
    print('监听者1 收到事件：$data');
  });

  // 监听 Stream 2
  var subscription2 = stream.listen((data) {
    print('监听者2 收到事件：$data');
  });

  await Future.microtask(() {
    // 添加事件到 Stream
    controller.add(1);
    controller.add(2);
    controller.add(3);
  });

  await Future.delayed(const Duration(seconds: 1));
  // 关闭 StreamController
  controller.close();

  // 取消监听
  subscription1.cancel();
  subscription2.cancel();
}
