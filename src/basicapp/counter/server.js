const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());

// Read starting hits from environment variable or default to 0
let hits = parseInt(process.env.START_HITS) || 0;

app.get("/hits", (req, res) => {
  hits++;
  console.log(`[${new Date().toISOString()}] /hits endpoint called. Hits = ${hits}`);
  res.json({ hits });
});

const PORT = 3000;

const server = app.listen(PORT, () => {
  console.log(`Counter service running on port ${PORT}, starting hits: ${hits}`);
});

// Graceful shutdown
function shutdown(signal) {
  console.log(`Received ${signal}. Shutting down gracefully...`);
  server.close(() => {
    console.log("HTTP server closed");
    process.exit(0);
  });
  setTimeout(() => {
    console.error("Forcing shutdown");
    process.exit(1);
  }, 10000);
}

process.on("SIGTERM", shutdown);
process.on("SIGINT", shutdown);