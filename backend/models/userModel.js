//import connection
import db from "../config/database.js";

//get all users
export const getUsers = (result) => {
    // writing the query to get users, pass any error and results
  db.query("SELECT * FROM users", (err, results) => {
    if (err) {
      console.log(err); // if error get the err, set results as null
      result(err, null); // if set error as null, get the results
    } else {
      result(null, results);
    }
  });
};

//get single user
export const getUserById = (id, result) => {
  db.query("SELECT * FROM users WHERE id = ?", [id], (err, results) => {
      if (err) {
        console.log(err);
        result(err, null);
      } else {
        result(null, results[0]);  // get only one row, the first row queried in results
      }
    }
  );
};

//TODO: check for log in
export const verifyUser = (data, result) => {
  db.query("SELECT * FROM users WHERE email = ? and password = ?", 
    [data.email, data.password], 
    (err, results) => {
      if (err) {
        console.log(err);s
        result(err, null);
      } else {
        result(null, results[0]);  // get only one row, the first row queried in results
      }
    }
  );
};

//insert user to database
export const insertUser = (data, result) => {
  db.query("INSERT INTO users SET ?", [data], (err, results) => {
    if (err) {
      console.log(err);
      result(err, null);
    } else {
      result(null, results);
    }
  });
};

// Update user to Database
// TODO: include password at the moment for the update user
export const updateUserById = (data, id, result) => {
  db.query(
    "UPDATE users SET password = ?, first_name = ?, last_name = ?, phone_number = ?, email = ? WHERE id = ?",
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

// Delete user to Database
export const deleteUserById = (id, result) => {
    // set user type to deleted to avoid orphaned data ?
  db.query("UPDATE users SET user_type = 'deleted' WHERE id = ?", [id], (err, results) => {
    if (err) {
      console.log(err);
      result(err, null);
    } else {
      result(null, results);
    }
  });
};

// TODO: CHECK IF USING BY ID IS APPLICABLE FOR LOGGED IN USERS; THIS PART IS A DRAFT

// TODO: ADD MODEL FOR INSERTCLIENT (HOW TO GET USER ID)
export const insertClient = (data, result) => {
    db.query("INSERT INTO client SET ?", [data], (err, results) => {
      if (err) {
        console.log(err);
        result(err, null);
      } else {
        result(null, results);
      }
    });
  };
// TODO: ADD MODEL FOR UPDATECLIENT -- PROFILE UPDATE
export const updateClientById = (data, id, result) => {
    // TODO: EDIT QUERY FOR CLIENTS
    db.query(
      "UPDATE users SET password = ?, first_name = ?, last_name = ?, phone_number = ?, email = ? WHERE id = ?",
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

// TODO: ADD MODEL FOR GETCLIENT -- IN CASE
export const getClients = (result) => {
  db.query("SELECT * FROM client", (err, results) => {
    if (err) {
      console.log(err); // if error get the err, set results as null
      result(err, null); // if set error as null, get the results
    } else {
      result(null, results);
    }
  });
};

// TODO: ADD MODEL FOR INSERTARTIST (HOW TO GET USER ID) --- ARTIST APPLICATION
export const insertArtist = (data, result) => {
    db.query("INSERT INTO artist SET ?", [data], (err, results) => {
      if (err) {
        console.log(err);
        result(err, null);
      } else {
        result(null, results);
      }
    });
  };

// TODO: ADD MODEL FOR UPDATEARTIST -- PROFILE UPDATE
export const updateArtistById = (data, id, result) => {
    // TODO: EDIT QUERY FOR ARTISTS
    db.query(
      "UPDATE users SET password = ?, first_name = ?, last_name = ?, phone_number = ?, email = ? WHERE id = ?",
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
// TODO: ADD MODEL FOR GETARTIST -- IN CASE
export const getArtists = (result) => {
  db.query("SELECT * FROM artist", (err, results) => {
    if (err) {
      console.log(err); // if error get the err, set results as null
      result(err, null); // if set error as null, get the results
    } else {
      result(null, results);
    }
  });
};

// TODO: ADD MODEL FOR INSERTADMIN (HOW TO GET USER ID)
export const insertAdmin = (data, result) => {
    db.query("INSERT INTO admin SET ?", [data], (err, results) => {
      if (err) {
        console.log(err);
        result(err, null);
      } else {
        result(null, results);
      }
    });
  };

// TODO: ADD MODEL FOR UPDATEADMIN -- PROFILE UPDATE
export const updateAdminById = (data, id, result) => {
    // TODO: EDIT QUERY FOR CLIENTS
    db.query(
      "UPDATE users SET password = ?, first_name = ?, last_name = ?, phone_number = ?, email = ? WHERE id = ?",
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

// TODO: ADD MODEL FOR GETADMIN -- MAYBE NOT
export const getAdmins = (result) => {
    db.query("SELECT * FROM admin", (err, results) => {
      if (err) {
        console.log(err); // if error get the err, set results as null
        result(err, null); // if set error as null, get the results
      } else {
        result(null, results);
      }
    });
  };