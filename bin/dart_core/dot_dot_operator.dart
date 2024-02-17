class Person {
  String name = '';
  int age = 0;
}

void main() {
  var person = Person()
    ..name = 'John'
    ..age = 30;

  print('Name: ${person.name}, Age: ${person.age}');
}
