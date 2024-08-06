import mongoose from "mongoose";

const agentSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, "A user must have a name"],
  },
  email: {
    type: String,
    required: [true, "Please provide your email"],
    unique: true,
  },
  phoneNumber: {
    type: Number,
    required: [true, "Please provide your phone number"],
    unique: true,
  },
  password: {
    type: String,
    required: [true, "Please provide a password"],
    select: false,
  },
  insuranceGroup: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "InsuranceProvider",
    required: [true, "An agent must be associated with an insurance group"],
  },
});

// CREATING AN OBJECT USER BASED ON THE USER SCHEMA
const Agent = mongoose.model("Agent", agentSchema);

// EXPORTING THE USER OBJECT
export default Agent;
