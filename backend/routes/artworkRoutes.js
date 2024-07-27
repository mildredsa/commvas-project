//import express
import express from "express";

//import functions from controller
import {
  showArtworks,
  showArtworkById,
  createArtwork,
  updateArtwork,
  deleteArtwork,
} from "../controllers/artworks.js";

//init express router
const router = express.Router();

//get all artwork
router.get("/artworks", showArtworks);

//get single artwork
router.get("/artworks/:id", showArtworkById);

// Create New Artwork
router.post("/artworks", createArtwork);

// Update Artwork
router.put("/artworks/:id", updateArtwork);

// Delete Artwork; Require the id
router.delete("/artworks/:id", deleteArtwork);

// TODO: ADD OTHER ROUTES FOR OTHER Artwork CONTROLLERS

//export default router
export default router;
