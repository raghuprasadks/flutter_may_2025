const express = require('express');
const app = express();
const cors = require('cors');
const connectDB = require('./db');

app.use(cors());
app.use(express.json());

const port = process.env.PORT || 5000;

let videosCollection;

// Initialize DB and collection
connectDB().then(db => {
  videosCollection = db.collection('videos');
 // app.listen(5001, () => console.log('VideoAPI running on port 5001'));
});

// CRUD Endpoints

// Get all videos
app.get('/api/videos', async (req, res) => {
  try {
    const videos = await videosCollection.find().toArray();
    res.json(videos);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch videos' });
  }
});

// Get video by id
app.get('/api/videos/:id', async (req, res) => {
  try {
    const video = await videosCollection.findOne({ id: req.params.id });
    if (!video) return res.status(404).json({ error: 'Video not found' });
    res.json(video);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch video' });
  }
});

// Create video
app.post('/api/videos', async (req, res) => {
    console.log("post video",req.body);
  const {title,description,price,imageUrl,youtubeUrl } = req.body;
  if (!title || !description || !price || !imageUrl || !youtubeUrl) {
    return res.status(400).json({ error: 'title, and url are required' });
  }
  try {
    await videosCollection.insertOne({title,description,price,imageUrl,youtubeUrl });
    res.status(201).json({ message: 'Video created' });
  } catch (err) {
    res.status(500).json({ error: 'Failed to create video' });
  }
});

// Update video
app.put('/api/videos/:id', async (req, res) => {
  const { title, url, description } = req.body;
  try {
    const result = await videosCollection.updateOne(
      { id: req.params.id },
      { $set: { title, url, description } }
    );
    if (result.matchedCount === 0) {
      return res.status(404).json({ error: 'Video not found' });
    }
    res.json({ message: 'Video updated' });
  } catch (err) {
    res.status(500).json({ error: 'Failed to update video' });
  }
});

// Delete video
app.delete('/api/videos/:id', async (req, res) => {
  try {
    const result = await videosCollection.deleteOne({ id: req.params.id });
    if (result.deletedCount === 0) {
      return res.status(404).json({ error: 'Video not found' });
    }
    res.json({ message: 'Video deleted' });
  } catch (err) {
    res.status(500).json({ error: 'Failed to delete video' });
  }
});

app.listen(port, () => {
    console.log(`VideoAPI running on port ${port}`);
    });