import mongoose from "mongoose";

const insuranceRequestModel = new mongoose.Schema({
  selfHelpGroup: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "SelfHelpGroup",
    required: true,
  },
  insuranceProvider: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "InsuranceProvider",
    required: true,
  },
  insurancePlan: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "InsurancePlan",
    required: true,
  },
  status: {
    type: String,
    enum: ["pending", "approved", "rejected"],
    default: "pending",
  },
  agent: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Agent",
    default: null,
  },
});

// CREATING AN OBJECT USER BASED ON THE USER SCHEMA
const InsuranceRequest = mongoose.model(
  "InsuranceRequest",
  insuranceRequestModel
);

// EXPORTING THE USER OBJECT
export default InsuranceRequest;
