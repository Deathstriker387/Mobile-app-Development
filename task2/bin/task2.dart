import 'package:task2/task2.dart' as task2;
import 'dart:io';

void main() {
  print("Enter your name: ");
  String? name = stdin.readLineSync();
  print("You entered: '$name'");
  print("Enter your age: ");
  String? ageInput = stdin.readLineSync();
  int? age = int.tryParse(ageInput ?? "");

  if (age == null) {
    print("Invalid age input. Exiting...");
    return;
  }

  if (age < 18) {
    print("Sorry $name, you are not eligible to register.");
    return;
  }

  stdout.write("How many numbers do you want to enter? ");
  String? countInput = stdin.readLineSync();
  int? count = int.tryParse(countInput ?? "");

  if (count == null || count <= 0) {
    print("Invalid number of entries. Exiting...");
    return;
  }

  List<int> numbers = [];

  for (int i = 0; i < count; i++) {
    stdout.write("Enter number ${i + 1}: ");
    String? input = stdin.readLineSync();
    int? num = int.tryParse(input ?? "");
    if (num == null) {
      print("Invalid input, try again.");
      i--;
    } else {
      numbers.add(num);
    }
  }

  int evenSum = 0;
  int oddSum = 0;
  int max = numbers[0];
  int min = numbers[0];

  for (int num in numbers) {
    if (num % 2 == 0) {
      evenSum += num;
    } else {
      oddSum += num;
    }

    if (num > max) max = num;
    if (num < min) min = num;
  }

  print("\n=== Results ===");
  print("Numbers entered: $numbers");
  print("Sum of even numbers: $evenSum");
  print("Sum of odd numbers: $oddSum");
  print("Largest number: $max");
  print("Smallest number: $min");
}
