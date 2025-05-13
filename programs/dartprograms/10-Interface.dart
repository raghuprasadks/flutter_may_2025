/**
 * Every class in Dart implicitly defines an interface. You can implement one or more interfaces using the implements keyword.
 */

class Animal {
  void eat() => print("Animal is eating");
}

class Swimmer {
  void swim() => print("Swimming");
}

// Dog implements two interfaces: Animal and Swimmer
class Dog implements Animal, Swimmer {
  @override
  void eat() => print("Dog is eating");

  @override
  void swim() => print("Dog is swimming");
}

void main(){
  Dog dog = Dog();
  dog.eat(); // Output: Dog is eating
  dog.swim(); // Output: Dog is swimming
}