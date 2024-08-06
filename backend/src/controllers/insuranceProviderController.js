import Agent from "../models/agentModel.js";
import InsurancePlan from "../models/insurancePlanModel.js";
import InsuranceProvider from "../models/insuranceProviderModel.js";
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

  const insuranceProvider = await InsuranceProvider.findOne({ email }).select(
    "+password"
  );

  if (!insuranceProvider || insuranceProvider.password !== password) {
    return next(new AppError("Incorrect email or password!", 401));
  }

  createSendToken(insuranceProvider, 200, res);
});

export const createInsuranceProvider = catchAsync(async (req, res, next) => {
  const { name, email, password, location } = req.body;

  const newProvider = await InsuranceProvider.create({
    name,
    email,
    password,
    location: {
      type: "Point",
      coordinates: location.coordinates,
    },
  });

  res.status(200).json({
    status: "success",
    InsuranceProvider: newProvider,
  });
});

export const createInsurancePlan = catchAsync(async (req, res, next) => {
  const { name, coverage, premium } = req.body;
  const insuranceProviderId = req.params.id;

  const newPlan = await InsurancePlan.create({
    name,
    coverage,
    premium,
    insuranceProvider: insuranceProviderId,
  });

  res.status(200).json({
    status: "success",
    InsurancePlan: newPlan,
  });
});

export const getInsuranceRequests = catchAsync(async (req, res, next) => {
  const insuranceProviderId = req.params.id;

  const insuranceRequests = await InsuranceRequest.find({
    insuranceProvider: insuranceProviderId,
  });

  res.status(200).json({
    status: "success",
    insuranceRequests,
  });
});

export const rejectInsuranceRequest = catchAsync(async (req, res, next) => {
  const { insuranceRequestId } = req.body;
  const insuranceRequest = await InsuranceRequest.findById(insuranceRequestId);
  const insuranceProviderId = req.params.id;

  if (insuranceRequest.status !== "pending") {
    return next(
      new AppError("Insurance request has already been processed!", 400)
    );
  }

  if (insuranceRequest.insuranceProvider.toString() !== insuranceProviderId) {
    return next(
      new AppError(
        "You are not authorized to reject this insurance request!",
        403
      )
    );
  }

  insuranceRequest.status = "rejected";
  insuranceRequest.save();

  res.status(200).json({
    status: "success",
    insuranceRequest,
  });
});

export const approveInsuranceRequest = catchAsync(async (req, res, next) => {
  const { insuranceRequestId } = req.body;
  const insuranceRequest = await InsuranceRequest.findById(insuranceRequestId);
  const insuranceProviderId = req.params.id;

  if (insuranceRequest.status !== "pending") {
    return next(
      new AppError("Insurance request has already been processed!", 400)
    );
  }

  if (insuranceRequest.insuranceProvider.toString() !== insuranceProviderId) {
    return next(
      new AppError(
        "You are not authorized to reject this insurance request!",
        403
      )
    );
  }

  const agents = await Agent.find({
    insuranceGroup: insuranceRequest.insuranceProvider,
  });
  const index = getRandomNumberBetween(0, agents.length);

  insuranceRequest.agent = agents[index]._id;
  insuranceRequest.status = "approved";
  insuranceRequest.save();

  res.status(200).json({ status: "success", insuranceRequest });
});

export const getLoanRequests = catchAsync(async (req, res, next) => {
  const insuranceProviderId = req.params.id;

  const loanRequests = await LoanRequest.find({
    loanProvider: insuranceProviderId,
  });

  res.status(200).json({
    status: "success",
    loanRequests,
  });
});

export const rejectLoanRequest = catchAsync(async (req, res, next) => {
  const { loanRequestId } = req.body;
  const insuranceProviderId = req.params.id;
  const loanRequest = await LoanRequest.findById(loanRequestId);

  if (loanRequest.status !== "pending") {
    return next(new AppError("Loan request has already been processed!", 400));
  }

  if (loanRequest.loanProvider.toString() !== insuranceProviderId) {
    return next(
      new AppError("You are not authorized to reject this loan request!", 403)
    );
  }

  loanRequest.status = "rejected";
  loanRequest.save();

  res.status(200).json({
    status: "success",
    loanRequest,
  });
});

export const approveLoanRequest = catchAsync(async (req, res, next) => {
  const { loanRequestId } = req.body;
  const loanRequest = await LoanRequest.findById(loanRequestId);
  const insuranceProviderId = req.params.id;

  if (loanRequest.status !== "pending") {
    return next(new AppError("Loan request has already been processed!", 400));
  }

  if (loanRequest.loanProvider.toString() !== insuranceProviderId) {
    return next(
      new AppError("You are not authorized to reject this loan request!", 403)
    );
  }

  const agents = await Agent.find({ insuranceGroup: loanRequest.loanProvider });
  const index = getRandomNumberBetween(0, agents.length);

  loanRequest.agent = agents[index]._id;
  loanRequest.status = "approved";
  loanRequest.save();

  res.status(200).json({
    status: "success",
    loanRequest,
  });
});

export const createAgent = catchAsync(async (req, res, next) => {
  const { name, email, phoneNumber, password } = req.body;
  const insuranceProviderId = req.params.id;

  const newAgent = await Agent.create({
    name,
    email,
    phoneNumber,
    password,
    insuranceGroup: insuranceProviderId,
  });

  res.status(201).json({
    status: "success",
    Agent: newAgent,
  });
});

function getRandomNumberBetween(min, max) {
  return Math.floor(Math.random() * (max - min) + min);
}
