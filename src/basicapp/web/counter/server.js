const express = require("express");

const app = express();
const port = 3000;

let hits = 0;

app.get("/hits", (req, res) => {
    hits++;
    res.json({ hits: hits });
});

app.listen(port, () => {
    console.log(`Counter service running on port ${port}`);
});