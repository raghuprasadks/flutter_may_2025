import 'package:demodart/demodart.dart' as demodart;
import 'test.dart' as test;

void main(List<String> arguments) {
  print('Hello world: ${demodart.calculate()}!');
  print("simple interest: ${demodart.SimpleInterest(1000, 5, 2)}");
  test.main();
}
