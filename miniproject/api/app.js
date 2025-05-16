const express = require('express');
const app = express();
const cors = require('cors');
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

app.post('/api/videos', async (req, res) => {
    const { title, description, url } = req.body;
    if (!title || !description || !price || !imageurl || !youtubeurl) {
        return res.status(400).json({ error: 'Title, description, and URL are required' });
    }

    try {
        const video = { title, description, price,imageurl, youtubeurl };
        const result = await videoCollection.insertOne(video);
        res.status(201).json(result.ops[0]);
    } catch (error) {
        console.error('Error inserting video:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
})

app.get('/api/videos', async (req, res) => {
    try {
        const videos = await videoCollection.find().toArray();
        res.status(200).json(videos);
    } catch (error) {
        console.error('Error fetching videos:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});



