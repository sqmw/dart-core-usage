import 'dart:io';

abstract class AnimalAction {
  final String name;

  AnimalAction(this.name);

  void crow();
}

mixin AnimalMixin on AnimalAction {
  @override
  void crow() {
    // TODO: implement crow
    print('Animal crow');
  }
}

class Dog extends AnimalAction with AnimalMixin {
  Dog(String name) : super(name);

  @override
  void crow() {
    print('dog crow');
  }
}

Future<void> main() async {
  AnimalAction dog = Dog('sDog');
  dog.crow();

  /// 直接申明了一个变量，用来存储
  dynamic res;
  try {
    res = 1 / 0;
  } on Exception catch (e) {
    print(e); // 不执行
  } finally {
    print(res);
  }

  try {
    throw Exception('my err');
  } on Exception {
    stderr.write('null err');
    await stderr.flush();
    await stderr.close();
  }
}
