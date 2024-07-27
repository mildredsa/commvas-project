//import connection
import db from "../config/database.js";

//get all artworks
export const getArtworks = (result) => {
    // writing the query to get artworks, pass any error and results
  db.query("SELECT * FROM artwork", (err, results) => {
    if (err) {
      console.log(err); // if error get the err, set results as null
      result(err, null); // if set error as null, get the results
    } else {
      result(null, results);
    }
  });
};

//get single artwork
export const getArtworkById = (id, result) => {
  db.query("SELECT * FROM artwork WHERE id = ?", [id], (err, results) => {
      if (err) {
        console.log(err);
        result(err, null);
      } else {
        result(null, results[0]);  // get only one row, the first row queried in results
      }
    }
  );
};

//insert artwork to database
export const insertArtwork = (data, result) => {
  db.query("INSERT INTO artwork SET ?", [data], (err, results) => {
    if (err) {
      console.log(err);
      result(err, null);
    } else {
      result(null, results);
    }
  });
};

// Update artwork to Database
export const updateArtworkById = (data, id, result) => {
  db.query(
    // TODO: EDIT QUERY FOR ARTWORK
    "UPDATE artwork SET password = ?, first_name = ?, last_name = ?, phone_number = ?, email = ? WHERE id = ?",
    [data.password, data.first_name, data.last_name, data.phone_number, data.email, id],
    (err, results) => {
      if (err) {
        console.log(err);  
        result(err, null);
      } else {
        result(null, results);
      }
    }
  );
};

// Delete artwork to Database
export const deleteArtworkById = (id, result) => {
    // set artwork type to deleted to avoid orphaned data ?
  db.query("DELETE FROM artwork WHERE id = ?", [id], (err, results) => {
    if (err) {
      console.log(err);
      result(err, null);
    } else {
      result(null, results);
    }
  });
};
