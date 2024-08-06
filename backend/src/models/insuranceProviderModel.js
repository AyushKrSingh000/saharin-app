import mongoose from "mongoose";

const insuranceProviderModel = new mongoose.Schema({
  name: {
    type: String,
    required: [true, "A user must have a name"],
  },
  email: {
    type: String,
    required: [true, "Please provide your email"],
    unique: true,
  },
  password: {
    type: String,
    required: [true, "Please provide a password"],
    select: false,
  },
  location: {
    type: {
      type: String,
      enum: ["Point"],
      required: true,
    },
    coordinates: {
      type: [Number],
      required: [true, "Insurance provider must have a location"],
    },
  },
});

// CREATING AN OBJECT USER BASED ON THE USER SCHEMA
const InsuranceProvider = mongoose.model(
  "InsuranceProvider",
  insuranceProviderModel
);

// EXPORTING THE USER OBJECT
export default InsuranceProvider;
