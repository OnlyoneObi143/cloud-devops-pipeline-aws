const express = require('express');
const app = express();
const port = process.env.PORT || 3001; //sets the port number the app will listen on

//sends message to user when the website is visted
app.get('/', (req, res) => {
  res.send('Hello from your AWS DevOps project!');
});

//starts sever and listens for requests
app.listen(port, () => {
  console.log(`App running on http://localhost:${port}`);
});
