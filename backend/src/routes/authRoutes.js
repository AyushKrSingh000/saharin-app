import express from "express";
import {
  getMe,
  getProfile,
  logout,
  protect,
} from "../controllers/authController.js";

const router = express.Router();

router.get("/logout", logout);

router.use(protect);

router.get("/profile", getMe, getProfile);

export default router;
