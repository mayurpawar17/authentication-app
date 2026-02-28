import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";

let users = []; // Temporary DB store

// Helper: Token Generation
const generateAccessToken = (user) => {
  return jwt.sign(user, process.env.ACCESS_SECRET, { expiresIn: "15m" });
};

const generateRefreshToken = (user) => {
  return jwt.sign(user, process.env.REFRESH_SECRET, { expiresIn: "7d" });
};

// Signup Logic
export const signup = async (req, res) => {
  const { email, password } = req.body;
  const hashedPassword = await bcrypt.hash(password, 10);
  users.push({ email, password: hashedPassword });
  res.json({ message: "User registered" });
};

// Login Logic
export const login = async (req, res) => {
  const { email, password } = req.body;
  const user = users.find((u) => u.email === email);

  if (!user) return res.status(400).json({ message: "User not found" });

  const validPassword = await bcrypt.compare(password, user.password);
  if (!validPassword)
    return res.status(400).json({ message: "Invalid password" });

  const accessToken = generateAccessToken({ email: user.email });
  const refreshToken = generateRefreshToken({ email: user.email });

  res.json({ accessToken, refreshToken });
};

// Refresh Logic
export const refreshToken = (req, res) => {
  const { refreshToken } = req.body;
  if (!refreshToken) return res.sendStatus(401);

  jwt.verify(refreshToken, process.env.REFRESH_SECRET, (err, user) => {
    if (err) return res.sendStatus(403);
    const newAccessToken = generateAccessToken({ email: user.email });
    res.json({ accessToken: newAccessToken });
  });
};
