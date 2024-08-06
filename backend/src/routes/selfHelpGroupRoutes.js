import express from "express";
import { getMe, protect } from "../controllers/authController.js";
import {
  createInsuranceRequest,
  createLoanRequest,
  createSelfHelpGroup,
  getAllInsurancePlans,
  getAllInsuranceProviders,
  login,
} from "../controllers/selfHelpGroupController.js";

const router = express.Router();

router.post("/create", createSelfHelpGroup);
router.post("/login", login);
router.get("/insurancePlans", getAllInsurancePlans);
router.get("/insuranceProviders", getAllInsuranceProviders);

router.use(protect);

router.post("/loanRequest", getMe, createLoanRequest);
router.post("/insuranceRequest", getMe, createInsuranceRequest);

export default router;
