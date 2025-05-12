void main(){
  print("collections");
  // List
  List<String> fruits = ["apple", "banana", "cherry"];
  print(fruits);
  print(fruits[0]);
  print(fruits.length);
  fruits.add("orange");
  print(fruits);
  fruits.remove("banana");
  print(fruits);
  fruits.insert(1, "kiwi");
  print(fruits);
  fruits.sort();
  print(fruits);
  // Set
  Set<String> vegetables = {"carrot", "broccoli", "spinach"};
  print(vegetables);
  print(vegetables.length);
  vegetables.add("potato");
  print(vegetables);
  vegetables.remove("broccoli");
  print(vegetables);
  // Map
  Map<String, int> ages = {"Alice": 25, "Bob": 30, "Charlie": 35};
  print(ages);
  print(ages["Alice"]);
  ages["Alice"] = 26;
  print(ages);
  ages.remove("Bob");
  print(ages);
  // Iterating over collections
  for (String fruit in fruits) {
    print(fruit);
  }
  for (String vegetable in vegetables) {
    print(vegetable);
  }
  for (String name in ages.keys) {
    print("$name is ${ages[name]} years old");
  }
  // List of maps
  List<Map<String, String>> people = [
    {"name": "Alice", "city": "New York"},
    {"name": "Bob", "city": "Los Angeles"},
    {"name": "Charlie", "city": "Chicago"}
  ];
  for (Map<String, String> person in people) {
    print("${person['name']} lives in ${person['city']}");
  }


}