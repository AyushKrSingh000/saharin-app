import mongoose from 'mongoose'

const selfHelpGroupSchema = new mongoose.Schema({
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
    select: false,
  },
  type: {
    type: String,
    enum: ['SHG', 'Environment Institution', 'NGO'],
  },
  memberCount: {
    type: Number,
    default: 10,
  },
})

// CREATING AN OBJECT USER BASED ON THE USER SCHEMA
const SelfHelpGroup = mongoose.model('SelfHelpGroup', selfHelpGroupSchema)

// EXPORTING THE USER OBJECT
export default SelfHelpGroup
