void main(){
  print("class and object");
  Employee emp1 = Employee(1, "John Doe", "IT", "Software Engineer", 60000);
  emp1.display();
  print(emp1);
}

class Employee{
  int? id;
  String? name;  
  String? department;
  String? designation;
  int? salary;

  Employee(this.id, this.name, this.department, this.designation, this.salary);
  // Employee(this.id, this.name, this.department, this.designation, this.salary);

  void display(){
    print("id: $id");
    print("name: $name");
    print("email: $department");
    print("designation: $designation");
    print("salary: $salary");

  }


  @override
  String toString() {
    return 'Employee(id: $id, name: $name, department: $department, designation: $designation, salary: $salary)';
  }
   
}