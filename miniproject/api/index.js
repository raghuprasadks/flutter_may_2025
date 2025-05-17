const express = require('express');
const app = express();
const cors = require('cors');

const videoRouter = require('./routes/video');
const userRouter = require('./routes/user');
const PORT = process.env.PORT || 5000;

//middleware
app.use(cors());
app.use(express.json());

// Use the video router for /api/videos
app.use('/api/videos', videoRouter);
app.use('/api/users', userRouter);

// ...existing code to start server...

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
