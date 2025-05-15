console.log("welcome to node")

function greet(){
    console.log("hello world")
}
greet()
// to  run this file use the command
// node index.js

function add(a, b){
    return a + b
}
result =add(5,10)
console.log(result)

multiply = (a, b) => {
    return a * b
}
result = multiply(5,10)
console.log(result)

console.log("before api call ")

fetch('https://jsonplaceholder.typicode.com/todos/1')
      .then(response => response.json())
      .then(json => console.log(json))
console.log("after api call")
