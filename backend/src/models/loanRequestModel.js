import mongoose from "mongoose";

const loanRequestModel = new mongoose.Schema({
  selfHelpGroup: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "SelfHelpGroup",
    required: true,
  },
  loanProvider: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "InsuranceProvider",
    required: true,
  },
  amount: {
    type: Number,
    min: 0,
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
const LoanRequest = mongoose.model("LoanRequest", loanRequestModel);

// EXPORTING THE USER OBJECT
export default LoanRequest;
