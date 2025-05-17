const express = require('express');
//const app = express();
//const cors = require('cors');
const router = express.Router();
const { connectDB } = require('../db');

connectDB()
  .then(db => {
    usersCollection = db.collection('users');
    console.log(`connected to db`);
    
  })
  .catch(err => {
    console.error('Failed to connect to MongoDB', err);
  });

  router.get('/', async (req, res) => {
  try {
    const users = await usersCollection.find().toArray();
    res.json(users);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch users' });
  }
});

router.post('/', async (req, res) => {
    console.log("user",req.body);
  const { name, email, password } = req.body;
  if (!name || !email) {
    return res.status(400).json({ error: 'Name and email are required' });
  }
  try {
    const result = await usersCollection.insertOne({ name, email, password });
    console.log('User inserted:', result);
    res.status(201).json({ message: 'User created', user: { id: result.insertedId, name, email } });
  } catch (err) {
    console.error('Error inserting user:', err);
    res.status(500).json({ error: 'Failed to create user' });
  }
});

router.post('/login', async (req, res) => {
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

module.exports = router;

