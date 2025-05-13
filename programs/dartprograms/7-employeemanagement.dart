import '6-classnobject.dart' as emp;

void main(){
  EmployeeManagement empManagement = EmployeeManagement();
  emp.Employee emp1 = emp.Employee(1, "John Doe", "IT", "Software Engineer", 60000);  
  emp.Employee emp2 = emp.Employee(2, "Jane Smith", "HR", "Manager", 80000);
  emp.Employee emp3 = emp.Employee(3, "Alice Johnson", "Finance", "Analyst", 70000);
  emp.Employee emp4 = emp.Employee(4, "Bob Brown", "IT", "Developer", 50000);
  empManagement.addEmployee(emp1);
  empManagement.addEmployee(emp2);
  empManagement.addEmployee(emp3);
  empManagement.addEmployee(emp4);
  empManagement.displayEmployees();
  print("After removing employee with id 2");
  empManagement.removeEmployee(2);
  empManagement.displayEmployees();
  print("After searching employee with id 3");
  empManagement.searchEmployee(3);
  print("After updating employee with id 1");
  emp.Employee updatedEmp = emp.Employee(1, "John Doe", "IT", "Senior Software Engineer", 70000);
  empManagement.updateEmployee(1, updatedEmp);
  empManagement.displayEmployees();

}

class EmployeeManagement{
  List<emp.Employee> employees = [];

  void addEmployee(emp.Employee employee) {
    employees.add(employee);
  }

  void removeEmployee(int id) {
    employees.removeWhere((employee) => employee.id == id);
    
  }

  void displayEmployees() {
    for (var employee in employees) {
      employee.display();
    }
  }
  /**
  void searchEmployee(int id) {
    var employee = employees.firstWhere((employee) => employee.id == id, orElse: () => null);
    if (employee != null) {
      employee.display();
    } else {
      print("Employee not found");
    }
  }
 */
  void searchEmployee(int id) {
  try {
    var employee = employees.firstWhere((employee) => employee.id == id);
    employee.display();
  } catch (e) {
    print("Employee not found");
  }
}
  void updateEmployee(int id, emp.Employee updatedEmployee) {
    var index = employees.indexWhere((employee) => employee.id == id);
    if (index != -1) {
      employees[index] = updatedEmployee;
    } else {
      print("Employee not found");
    }
  }
}
