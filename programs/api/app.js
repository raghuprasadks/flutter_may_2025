const express = require('express');
const cors = require('cors');

const app = express();
const port = 5000;
// middleware
app.use(cors());
app.use(express.json());
var users =[]

app.get('/', (req, res) => {
  res.send('Hello World!');
});
app.get('/api', (req, res) => {
  res.json(users);
});

app.post('/api', (req, res) => {
    console.log("post method");
  const user = req.body;
  console.log('Received data:', user);
  users.push(user)
  res.json({ message: 'Sign Up Successful' });
})

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
    })