Future<int> futureF() async {
  await Future.delayed(const Duration(seconds: 1));
  return 1;
}

Future<int> futureS() async {
  await Future.delayed(const Duration(seconds: 2));
  return 2;
}

void main() async {
  var tStart = DateTime.timestamp().millisecondsSinceEpoch;

  /// Future.sync() 将 iterable 的 FutureList 进行轮询执行(单线程，但是轮询)
  /// @return: List<dynamic>
  var res = await Future.wait([futureF(), futureS()]);
  print(DateTime.timestamp().millisecondsSinceEpoch - tStart);
  print(res);
}
