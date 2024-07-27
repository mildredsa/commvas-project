//import express
import express from "express";

//import functions from controller
import {
  showUsers,
  showUserById,
  createUser,
  updateUser,
  deleteUser,
  authenticateUser,
} from "../controllers/users.js";

//init express router
const router = express.Router();

//get all user
router.get("/users", showUsers);

//get single user
router.get("/users/:id", showUserById);

// TODO: edit query for log in as email and password
router.get("/users", authenticateUser);

// Create New User
router.post("/users", createUser);

// Update User
router.put("/users/:id", updateUser);

// Delete User; Require the id
router.delete("/users/:id", deleteUser);

// TODO: ADD OTHER ROUTES FOR OTHER USER CONTROLLERS

//export default router
export default router;
