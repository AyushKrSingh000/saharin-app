import SelfHelpGroup from "../models/selfHelpGroupModel.js";
import catchAsync from "../utils/catchAsync.js";
import AppError from "../utils/AppError.js";
import InsuranceRequest from "../models/insuranceRequestModel.js";
import InsurancePlan from "../models/insurancePlanModel.js";
import { createSendToken } from "./authController.js";
import LoanRequest from "../models/loanRequestModel.js";
import InsuranceProvider from "../models/insuranceProviderModel.js";

export const login = catchAsync(async (req, res, next) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return next(new AppError("Please provide email and password!", 400));
  }

  const selfHelpGroup = await SelfHelpGroup.findOne({ email }).select(
    "+password"
  );

  if (!selfHelpGroup || selfHelpGroup.password !== password) {
    return next(new AppError("Incorrect email or password!", 401));
  }

  createSendToken(selfHelpGroup, 200, res);
});

export const createSelfHelpGroup = catchAsync(async (req, res, next) => {
  const { email, password, type, memberCount } = req.body;

  const selfHelpGroup = await SelfHelpGroup.create({
    email,
    password,
    type,
    memberCount,
  });

  res.status(201).json({
    status: "success",
    selfHelpGroup,
  });
});

export const createInsuranceRequest = catchAsync(async (req, res, next) => {
  const selfHelpGroupId = req.params.id;
  const { insuranceProviderId, insurancePlanId, amount } = req.body;

  const newInsuranceRequest = InsuranceRequest.create({
    selfHelpGroup: selfHelpGroupId,
    insuranceProvider: insuranceProviderId,
    insurancePlan: insurancePlanId,
  });

  res.status(201).json({
    status: "success",
    newInsuranceRequest,
  });
});

export const createLoanRequest = catchAsync(async (req, res, next) => {
  const selfHelpGroupId = req.params.id;
  const { loanProviderId, amount } = req.body;

  const newLoanRequest = LoanRequest.create({
    selfHelpGroup: selfHelpGroupId,
    loanProvider: loanProviderId,
    amount,
  });

  res.status(201).json({
    status: "success",
  });
});

export const getAllInsuranceProviders = catchAsync(async (req, res, next) => {
  const insuranceProviders = await InsuranceProvider.find();

  res.status(200).json({
    status: "success",
    insuranceProviders,
  });
});

export const getAllInsurancePlans = catchAsync(async (req, res, next) => {
  const insurancePlans = await InsurancePlan.find();

  res.status(200).json({
    status: "success",
    insurancePlans,
  });
});
