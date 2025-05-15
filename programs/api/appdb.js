const express = require('express');
const app = express();
const cors = require('cors');
const { MongoClient } = require('mongodb');

let port = process.env.PORT || 5000;
const mongoUrl = 'mongodb://localhost:27017'; // Change if needed
const dbName = 'fluttertutorial'; // Change if needed

app.use(cors());
app.use(express.json());

let db, usersCollection;

// Connect to MongoDB
MongoClient.connect(mongoUrl, { useUnifiedTopology: true })
  .then(client => {
    db = client.db(dbName);
    usersCollection = db.collection('users');
    app.listen(port, () => {
      console.log(`Server is running on port ${port}`);
    });
  })
  .catch(err => {
    console.error('Failed to connect to MongoDB', err);
  });

app.get('/', (req, res) => {
  res.send('api');
});

app.get('/api/user', async (req, res) => {
  try {
    const users = await usersCollection.find().toArray();
    res.json(users);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch users' });
  }
});

app.post('/api/user', async (req, res) => {
    console.log("user",req.body);
  const { name, email, password } = req.body;
  if (!name || !email) {
    return res.status(400).json({ error: 'Name and email are required' });
  }
  try {
    const result = await usersCollection.insertOne({ name, email, password });
    res.status(201).json({ message: 'User created', user: { id: result.insertedId, name, email } });
  } catch (err) {
    res.status(500).json({ error: 'Failed to create user' });
  }
});

app.post('/api/login', async (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    return res.status(400).json({ error: 'Email and password are required' });
  }
  try {
    const user = await usersCollection.findOne({ email, password });
    if (!user) {
      return res.status(401).json({ error: 'Invalid email or password' });
    }
    res.json({ message: 'Login successful', user });
  } catch (err) {
    res.status(500).json({ error: 'Login failed' });
  }
});