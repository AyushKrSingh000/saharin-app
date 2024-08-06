import express from "express";
import { protect, getMe } from "./../controllers/authController.js";
import {
  approveInsuranceRequest,
  approveLoanRequest,
  createAgent,
  createInsurancePlan,
  createInsuranceProvider,
  getInsuranceRequests,
  getLoanRequests,
  login,
  rejectInsuranceRequest,
  rejectLoanRequest,
} from "../controllers/insuranceProviderController.js";

const router = express.Router();

router.post("/signup", createInsuranceProvider);
router.post("/login", login);

// USER MUST BE LOGGED IN TO ACCESS THE FOLLOWING ROUTES
router.use(protect);

router.get("/insuranceRequests", getMe, getInsuranceRequests);
router.get("/loanRequests", getMe, getLoanRequests);
router.patch("/rejectLoanRequest", getMe, rejectLoanRequest);
router.patch("/approveLoanRequest", getMe, approveLoanRequest);
router.patch("/rejectInsuranceRequest", getMe, rejectInsuranceRequest);
router.patch("/approveInsuranceRequest", getMe, approveInsuranceRequest);
router.post("/insurancePlan", getMe, createInsurancePlan);
router.post("/agent", getMe, createAgent);

export default router;
