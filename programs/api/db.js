const { MongoClient } = require('mongodb');

const mongoUrl = 'mongodb://localhost:27017';
const dbName = 'ecomdb';

let db;

async function connectDB() {
  if (db) return db;
  const client = await MongoClient.connect(mongoUrl, { useUnifiedTopology: true });
  db = client.db(dbName);
  return db;
}

module.exports = connectDB;