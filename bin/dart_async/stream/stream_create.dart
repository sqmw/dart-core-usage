import 'dart:async';
import 'dart:io';

/// 通过 StreamController 创建 Stream
void createStreamByStreamController() {
  StreamController streamController = StreamController<dynamic>();
  Future.microtask(() async {
    for (int i = 0; i < 1000; i++) {
      await Future.delayed(const Duration(milliseconds: 200));

      /// 这个函数直接回让当前进程 sleep 在这里
      sleep(const Duration(milliseconds: 200));
      streamController.add(i);
    }
  });
  Stream stream = streamController.stream;
  stream.listen((val) {
    print(val);
  });
}

/// 通过 async* yield 创建 Stream
Future<void> createStreamByYield() async {
  Stream<int> streamInt() async* {
    /// 这里并不会死在这里，因为使用了 Future.delayed()
    for (int i = 0; i < 1000; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      yield i;
    }
  }

  /// 这里将会进入 MicrotaskQueue
  streamInt().listen((val) {
    print(val);
  });

  for (int i = 0; i < 1000; i++) {
    await Future.delayed(const Duration(milliseconds: 200));
    print('async* yield');
  }
}
