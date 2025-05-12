void main(){
  // for loop
  print("for loop:");
  for (int i = 0; i < 5; i++) {
    print("$i");
  }
  // while loop
  print("while loop");
  int j = 0;
  while (j < 5) {
    print("$j");
    j++;
  }
print("do while");
  // do-while loop
  int k = 0;
  do {
    print("$k");
    k++;
  } while (k < 5);

  print("for each loop");
  // for-each loop
  List<String> names = ["Alice", "Bob", "Charlie"];
  names.forEach((name) {
    print(name);
  });
  print("for in loop");
  // for-in loop
  for (String name in names) {
    print(name);
  }


}