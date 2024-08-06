import express from "express";
import { getMe, protect } from "../controllers/authController.js";
import {
  getAllInsurances,
  getAllLoans,
  login,
} from "../controllers/agentController.js";

const router = express.Router();

router.post("/login", login);

router.use(protect);

router.get("/insurances", getMe, getAllInsurances);
router.get("/loans", getMe, getAllLoans);

export default router;
