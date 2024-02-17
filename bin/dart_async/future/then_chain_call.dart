void main() {
  // 模拟一个异步操作，返回一个Future
  Future<int> fetchData() async {
    // 模拟异步操作，等待2秒
    await Future.delayed(Duration(seconds: 2));
    return 42; // 假设异步操作返回数字 42
  }

  print('开始异步操作...');

  fetchData().then((result) {
    // 第一次.then处理异步操作的结果
    print('第一步结果: $result');
    return result * 2; // 对结果进行处理，返回一个新的Future
  }).then((result) {
    // 第二次.then处理新的Future的结果
    print('第二步结果: $result');
    return result + 10; // 对结果进行处理，返回一个新的Future
  }).then((result) {
    // 第三次.then处理新的Future的结果
    print('第三步结果: $result');
  }).catchError((error) {
    // 捕获可能的错误
    print('发生错误: $error');
  }).whenComplete(() {
    // 无论成功或失败都会执行的操作
    print('操作完成');
  });
}
