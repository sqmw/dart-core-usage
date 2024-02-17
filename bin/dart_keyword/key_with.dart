mixin Run {
  /// mixin没有构造函数
  String? name;

  void run() {
    print('I am running');
  }
}

class Cat with Run {
  // Cat(String name); // 不可行
  Cat(String name) {
    this.name = name;
  }

  @override
  void run() {
    // TODO: implement run
    print("$name is running");
  }
}

void main() {
  Cat cat = Cat('sCat');
  cat.run();
}
