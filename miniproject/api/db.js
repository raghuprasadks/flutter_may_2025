const { MongoClient } = require('mongodb');

const mongoUrl = 'mongodb://localhost:27017'; // Change if needed
const dbName = 'ecomdb'; // Change if needed

let db = null;

async function connectDB() {
    if (db) return db;
    const client = await MongoClient.connect(mongoUrl, { useUnifiedTopology: true });
    db = client.db(dbName);
    return db;
}

module.exports = { connectDB };