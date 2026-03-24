const request = require("supertest");
const app = require("./server");

describe("Hits API", () => {
  test("GET /hits increments counter", async () => {
    // Make first request
    const res1 = await request(app).get("/hits");
    expect(res1.statusCode).toBe(200);
    expect(res1.body.hits).toBeGreaterThanOrEqual(1);

    // Make second request
    const res2 = await request(app).get("/hits");
    expect(res2.statusCode).toBe(200);
    expect(res2.body.hits).toBe(res1.body.hits + 1);
  });

//   test("GET / returns simple message", async () => {
//     const res = await request(app).get("/");
//     expect(res.statusCode).toBe(200);
//     expect(res.text).toBe("Hits API running");
//   });
});