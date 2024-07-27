//import functions from Artwork model
import {
    getArtworks,
    getArtworkById,
    insertArtwork,
    updateArtworkById,
    deleteArtworkById,
  } from "../models/artworkModel.js";
  
  //  get all artworks; (req, res) request and response so that whenever the path is called, we get access of request and response
  export const showArtworks = (req, res) => {
    getArtworks((err, results) => {
      if (err) {
        res.send(err);
      } else {
        res.json(results);
      }
    });
  };
  
  //get single artwork
  export const showArtworkById = (req, res) => {
    // req.params.id pass the id of the request
    getArtworkById(req.params.id, (err, results) => {
      if (err) {
        res.send(err);
      } else {
        res.json(results);
      }
    });
  };
  
  //create new artwork
  export const createArtwork = (req, res) => {
    const data = req.body;
    insertArtwork(data, (err, results) => {
      if (err) {
        res.send(err);
      } else {
        res.json(results);
      }
    });
  };
  
  // Update Artwork
  export const updateArtwork = (req, res) => {
    const data = req.body;
    const id = req.params.id;
    updateArtworkById(data, id, (err, results) => {
      if (err) {
        res.send(err);
      } else {
        res.json(results);
      }
    });
  };
  
  // Delete Artwork
  export const deleteArtwork = (req, res) => {
    const id = req.params.id;
    deleteArtworkById(id, (err, results) => {
      if (err) {
        res.send(err);
      } else {
        res.json(results);
      }
    });
  };


  // TODO: ADD CONTROLLERS FOR OTHER MODELS IN ArtworkMODEL