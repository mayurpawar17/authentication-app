import express from "express";
import cors from "cors";
import authRoutes from "./routes/auth.js";

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use("/api/auth", authRoutes);

app.get("/api/health", (req, res) => {
  res.send("hello world");
});

export default app;
