import 'package:task3/task3.dart' as task3;
import 'dart:io';
void main(List<String> arguments) {
 print("enter number");
 String? numinput = stdin.readLineSync();
 int? num = int.tryParse(numinput ?? "");
 if (num == null) {
  print("Invalid number input");
  return;
 }

 for (int i=1;i<=num;i++){
  for (int j=1;j<=i;j++){
   stdout.write(" $j");
  }
  print("");
 }
}
