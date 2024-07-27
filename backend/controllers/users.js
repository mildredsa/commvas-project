//import functions from User model
import {
    getUsers,
    getUserById,
    insertUser,
    updateUserById,
    deleteUserById,
    verifyUser,
  } from "../models/userModel.js";
  
  //  get all users; (req, res) request and response so that whenever the path is called, we get access of request and response
  export const showUsers = (req, res) => {
    getUsers((err, results) => {
      if (err) {
        res.send(err);
      } else {
        res.json(results);
      }
    });
  };
  
  //get single user
  export const showUserById = (req, res) => {
    // req.params.id pass the id of the request
    getUserById(data, (err, results) => {
      if (err) {
        res.send(err);
      } else {
        res.json(results);
      }
    });
  };

  //TODO: check for log in
  export const authenticateUser = (req, res) => {
    const data = req.body;
    verifyUser(data, (err, results) => {
      if (err) {
        res.send(err);
      } else {
        res.json(results);
      }
    });
  };
  
  
  //create new User
  export const createUser = (req, res) => {
    const data = req.body;
    insertUser(data, (err, results) => {
      if (err) {
        res.send(err);
      } else {
        res.json(results);
      }
    });
  };
  
  // Update User
  export const updateUser = (req, res) => {
    const data = req.body;
    const id = req.params.id;
    updateUserById(data, id, (err, results) => {
      if (err) {
        res.send(err);
      } else {
        res.json(results);
      }
    });
  };
  
  // Delete User
  export const deleteUser = (req, res) => {
    const id = req.params.id;
    deleteUserById(id, (err, results) => {
      if (err) {
        res.send(err);
      } else {
        res.json(results);
      }
    });
  };


  // TODO: ADD CONTROLLERS FOR OTHER MODELS IN USERMODEL