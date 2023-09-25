import request from "supertest";
import app from "../../src/app";

describe("Hello", () => {
  it("GET /", async () => {
    const response = await request(app).get("/");
    expect(response.status).toBe(200);
  });
});
