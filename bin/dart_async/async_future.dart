import 'dart:io';

/// Future 的Event Queue 加入各种执行任务
/// Future 的各种具名构造函数
///
/// Future & async await
///
///
/// Future(() {}); // task 进入 EventQueue
/// Future.microtask(() {}); // task 进入 MicrotaskQueue
/// Future.value();
/// Future.sync(() {});

void main() {
  assert("Every thing goes well" == 'true');
}
