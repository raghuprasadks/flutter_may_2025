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
    productsCollection = db.collection('products');
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

// ...existing user routes...

// Product CRUD APIs

// Get all products
app.get('/api/products', async (req, res) => {
  try {
    const products = await productsCollection.find().toArray();
    res.json(products);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch products' });
  }
});

// Get a product by id
app.get('/api/products/:id', async (req, res) => {
  try {
    const product = await productsCollection.findOne({ id: req.params.id });
    if (!product) return res.status(404).json({ error: 'Product not found' });
    res.json(product);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch product' });
  }
});

// Create a new product
app.post('/api/products', async (req, res) => {
  const { name, supplier, price } = req.body;
  if (!name || !supplier || price === undefined) {
    return res.status(400).json({ error: 'All fields are required' });
  }
  try {
    const result = await productsCollection.insertOne({ name, supplier, price });
    res.status(201).json({ message: 'Product created', product: { name, supplier, price } });
  } catch (err) {
    res.status(500).json({ error: 'Failed to create product' });
  }
});

// Update a product by id
app.put('/api/products/:id', async (req, res) => {
  const { name, supplier, price } = req.body;
  try {
    const result = await productsCollection.updateOne(
      { id: req.params.id },
      { $set: { name, supplier, price } }
    );
    if (result.matchedCount === 0) {
      return res.status(404).json({ error: 'Product not found' });
    }
    res.json({ message: 'Product updated' });
  } catch (err) {
    res.status(500).json({ error: 'Failed to update product' });
  }
});

// Delete a product by id
app.delete('/api/products/:id', async (req, res) => {
  try {
    const result = await productsCollection.deleteOne({ id: req.params.id });
    if (result.deletedCount === 0) {
      return res.status(404).json({ error: 'Product not found' });
    }
    res.json({ message: 'Product deleted' });
  } catch (err) {
    res.status(500).json({ error: 'Failed to delete product' });
  }
});