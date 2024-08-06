import mongoose from "mongoose";

const insurancePlanModel = new mongoose.Schema({
  name: {
    type: String,
    required: [true, "A user must have a name"],
  },
  premium: {
    type: Number,
    required: [true, "Please provide the premium"],
  },
  coverage: {
    type: Number,
    required: [true, "Please provide the claim"],
  },
  insuranceProvider: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "InsuranceProvider",
  },
});

// CREATING AN OBJECT USER BASED ON THE USER SCHEMA
const InsurancePlan = mongoose.model("InsurancePlan", insurancePlanModel);

// EXPORTING THE USER OBJECT
export default InsurancePlan;
