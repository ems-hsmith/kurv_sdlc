const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());

let hits = parseInt(process.env.START_HITS) || 0;

app.get("/hits", (req, res) => {
  hits++;
  console.log(`[${new Date().toISOString()}] /hits called. Hits = ${hits}`);
  res.json({ hits });
});

// Export app for testing
module.exports = app;

// Start server only if not imported (i.e., not testing)
if (require.main === module) {
  const PORT = 3000;
  const server = app.listen(PORT, () => {
    console.log(`Counter service running on port ${PORT}, starting hits: ${hits}`);
  });

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
}