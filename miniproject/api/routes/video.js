const express = require('express');
//const app = express();
//const cors = require('cors');
const router = express.Router();
const { connectDB } = require('../db');
/** 
const { MongoClient } = require('mongodb');

let port = process.env.PORT || 5000;
const mongoUrl = 'mongodb://localhost:27017'; // Change if needed
const dbName = 'ecomdb'; // Change if needed

app.use(cors());
app.use(express.json());

let db, usersCollection;

// Connect to MongoDB
MongoClient.connect(mongoUrl, { useUnifiedTopology: true })
  .then(client => {
    db = client.db(dbName);
   
    videoCollection = db.collection('videos');
    app.listen(port, () => {
      console.log(`Server is running on port ${port}`);
    });
  })
  .catch(err => {
    console.error('Failed to connect to MongoDB', err);
  });
*/

connectDB()
  .then(db => {
    videoCollection = db.collection('videos');
    console.log(`connected to db`);
    
  })
  .catch(err => {
    console.error('Failed to connect to MongoDB', err);
  });

router.post('/', async (req, res) => {
    console.log('Received request to add video:', req.body);
    const { title, description, price,imageUrl, youtubeUrl} = req.body;
    if (!title || !description || !price || !imageUrl || !youtubeUrl) {
        return res.status(400).json({ error: 'Title, description, and URL are required' });
    }
    console.log("after validation");
    try {
        const video = { title, description, price,imageUrl, youtubeUrl };
        const result = await videoCollection.insertOne(video);
        console.log('Video inserted:', result);

        res.status(201).json(result);
    } catch (error) {
        console.error('Error inserting video:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
})

router.get('/', async (req, res) => {
    console.log('Received request to fetch videos');
    try {
        const videos = await videoCollection.find().toArray();
        res.status(200).json(videos);
    } catch (error) {
        console.error('Error fetching videos:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

module.exports = router;



