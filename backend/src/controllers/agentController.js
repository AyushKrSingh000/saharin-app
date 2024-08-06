import Agent from "../models/agentModel.js";
import InsuranceRequest from "../models/insuranceRequestModel.js";
import LoanRequest from "../models/loanRequestModel.js";
import AppError from "../utils/AppError.js";
import catchAsync from "../utils/catchAsync.js";
import { createSendToken } from "./authController.js";

export const login = catchAsync(async (req, res, next) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return next(new AppError("Please provide email and password!", 400));
  }

  const agent = await Agent.findOne({ email }).select("+password");

  if (!agent || agent.password !== password) {
    return next(new AppError("Incorrect email or password!", 401));
  }

  createSendToken(agent, 200, res);
});

export const getAllInsurances = catchAsync(async (req, res, next) => {
  const agentId = req.params.id;
  const insurances = await InsuranceRequest.find({ agent: agentId }).populate([
    "selfHelpGroup",
    "insuranceProvider",
  ]);

  res.status(200).json({
    status: "success",
    insurances,
  });
});

export const getAllLoans = catchAsync(async (req, res, next) => {
  const agentId = req.params.id;
  const loans = await LoanRequest.find({ agent: agentId }).populate([
    "selfHelpGroup",
    "loanProvider",
  ]);

  res.status(200).json({
    status: "success",
    loans,
  });
});
