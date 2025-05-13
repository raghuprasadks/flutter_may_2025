void main(){
  print("inheritance");
  // Inheritance
  // Inheritance is a mechanism in OOP that allows a class to inherit properties and methods from another class.
  // Inheritance allows for code reusability and establishes a relationship between classes.
  // In Dart, inheritance is achieved using the `extends` keyword.
  // The class that is inherited from is called the superclass (or parent class), and the class that inherits is called the subclass (or child class).
  // In Dart, a class can only extend one superclass (single inheritance), but it can implement multiple interfaces.
  // The subclass inherits all the properties and methods of the superclass, and it can also have its own properties and methods.
  // The subclass can override the methods of the superclass to provide its own implementation.
  // The `super` keyword is used to call the constructor of the superclass.
  // The `@override` annotation is used to indicate that a method is being overridden in the subclass.
  // Example of inheritance in Dart
  Dog dog = Dog();
  dog.eat(); // Inherited method from Animal class
  dog.bark(); // Method from Dog class
  Cat cat = Cat();
  cat.eat(); // Inherited method from Animal class
  cat.meow(); // Method from Cat class
  // Example of overriding a method in the subclass
  
}


class Animal {
  void eat() {
    print("Animal is eating");
  }
}
class Dog extends Animal {
  void bark() {
    print("Dog is barking");
  }
}
class Cat extends Animal {
  void meow() {
    print("Cat is meowing");
  }

  @override
  // Overriding the eat method from Animal class
  // This method will be called instead of the eat method from Animal class
  void eat() {
    print("Cat is eating");
  }
}