Future<void> handleStreamWithFor() async {
  Stream streamInt =
      Stream.fromIterable(List.generate(100, (index) => index + 1));
  ///
  await for (final num in streamInt){
    print(num);
  }
  ///
}

Future<void> handleStreamWithListen() async {
  Stream streamInt =
  Stream.fromIterable(List.generate(100, (index) => index + 1));
  ///
  streamInt.listen((event) {
    print(event);
  });
  ///
}

