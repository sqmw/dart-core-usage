import 'dart:convert';

///
/// jsonEncode()/jsonDecode():
///   支持类型:
///     1. 基本数据类型
///     2. hashMap&&array
/// 不支持变为支持
///   手动实现(对于已经深入了解JSON的人,手动实现毫无意义):
///      实现 1. Map<String, dynamic> toJson()
///          2. factory ClassName.fromJson(Map<String, dynamic> objectMapName)
///   使用第三方包(推荐) json_serializable 或 built_value

class Person {
  Person(this.name, this.grades);

  String name;
  Map grades;

  Map<String, dynamic> toJson() => {'name': name, 'grades': jsonEncode(grades)};

  factory Person.fromJson(Map<dynamic, dynamic> personMap) {
    return Person(personMap['name'], jsonDecode(personMap['grades']));
  }
}

void main() {
  Person person = Person("Jack", {'Math': 99, "Chinese": 100});

  /// OK
  // print(jsonEncode(person));
  var jsonPerson = jsonEncode(person);
  Person personNew = Person.fromJson(jsonDecode(jsonPerson));
  print(personNew);
}
