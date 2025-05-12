void main(){
  print("addition:");
  add(10,20);
  print("subtraction:");
  int result = subtract(20,10);
  print(result);
  print("multiplication - anonymous function:");
  int result2 = multiply(10,20);
  print(result2);
  print("division - arrow function:");
  double result3 = div(20,10);
  print(result3);
}
void add(int a, int b) {
  print(a + b);
}
int subtract(int a, int b) {
  return a - b;
} 
var multiply = (int a, int b) {
  return a * b;
};  
var div = (int a, int b) => a / b;  

