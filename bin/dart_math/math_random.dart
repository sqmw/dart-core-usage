import 'dart:math';

void main() {
  Random random = Random();

  /// [0, max)
  print(random.nextInt(111));

  /// default max = 1.0
  print(random.nextDouble());
}