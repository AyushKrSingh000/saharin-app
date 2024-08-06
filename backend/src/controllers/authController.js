import { promisify } from 'util'
import jwt from 'jsonwebtoken'
import AppError from '../utils/AppError.js'
import catchAsync from '../utils/catchAsync.js'
import InsuranceProvider from '../models/insuranceProviderModel.js'
import SelfHelpGroup from '../models/selfHelpGroupModel.js'
import Agent from '../models/agentModel.js'

// CREATE SIGN TOKEN
const signToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRES_IN,
  })
}

// CREATE TOKEN TO BE SENT TO BE ASSIGNED TO THE USER
export const createSendToken = (user, statusCode, res) => {
  const token = signToken(user._id)
  const cookieOptions = {
    expires: new Date(
      Date.now() + process.env.JWT_COOKIE_EXPIRES_IN * 24 * 60 * 60 * 1000
    ),
    httpOnly: true,
  }
  if (process.env.NODE_ENV === 'production') cookieOptions.secure = true

  res.cookie('jwt', token, cookieOptions)

  res.status(statusCode).json({
    status: 'success',
    token,
    data: {
      user,
    },
  })
}

// ROUTE TO LOGOUT
export const logout = (req, res) => {
  res.cookie('jwt', 'loggedout', {
    expires: new Date(Date.now() + 10 * 1000),
    httpOnly: true,
  })
  res.status(200).json({ status: 'success' })
}

// ROUTE TO CHECK WHETHER THE USER IS LOGGED IN
export const protect = catchAsync(async (req, res, next) => {
  // 1) Getting token and check of it's there
  let token
  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith('Bearer')
  ) {
    token = req.headers.authorization.split(' ')[1]
  } else if (req.cookies.jwt) {
    token = req.cookies.jwt
  }
  if (!token) {
    return next(
      new AppError('You are not logged in! Please log in to get access', 401)
    )
  }

  // 2) Verification token
  const decoded = await promisify(jwt.verify)(token, process.env.JWT_SECRET)

  // 3) Check if user still exists
  let currentUser = await SelfHelpGroup.findById(decoded.id)
  if (!currentUser) currentUser = await InsuranceProvider.findById(decoded.id)
  if (!currentUser) currentUser = await Agent.findById(decoded.id)

  if (!currentUser) {
    return next(
      new AppError(
        'The user belonging to this token does no longer exists',
        401
      )
    )
  }

  // GRANT ACCESS TO PROTECTED ROUTE
  req.user = currentUser
  res.locals.user = currentUser
  next()
})

export const getMe = (req, res, next) => {
  req.params.id = req.user.id
  next()
}

export const getProfile = catchAsync(async (req, res, next) => {
  const userId = req.params.id

  let user = await SelfHelpGroup.findById(userId)
  if (!user) user = await InsuranceProvider.findById(userId)
  if (!user) user = await Agent.findById(userId)

  res.status(200).json({
    status: 'success',
    user,
  })
})
