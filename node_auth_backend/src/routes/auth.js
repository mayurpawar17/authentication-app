import express from "express";
import { signup, login, refreshToken } from "../controllers/authController.js";
import { signupValidation, loginValidation } from "../middleware/authMiddleware.js";

const router = express.Router();

// Logic: Route -> Validation -> Controller
router.post("/signup", signupValidation, signup);
router.post("/login", loginValidation, login);
router.post("/refresh", refreshToken);

export default router;