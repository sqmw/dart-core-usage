import 'dart:async';

void main() {
  // 创建一个定时器，在1秒后执行回调函数
  Timer timer = Timer(Duration(seconds: 1), () {
    print('Timer callback executed after 1 second.');
  });

  /// Calling [cancel] more than once on a [Timer] is allowed, and
  /// will have no further effect.
  Future.delayed(const Duration(seconds: 2), () => timer.cancel());

  /// 类似 JavaScript 的 SetInterval(()=>{}, time_gap)
  Timer timerPeriodic = Timer.periodic(const Duration(seconds: 2), (timer) {
    print('timerPeriodic');
    Future.delayed(const Duration(seconds: 3), () {
      timer.cancel();
    });
  });

  /// 把这个任务丢进微任务队列
  Timer.run(() {
    print('static function Timer.run((){});');
  });
}
