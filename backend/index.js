//import express
import express from "express";

//import cors
import cors from "cors";

//import routes
import userRouter from "./routes/userRoutes.js";
import artworkRouter from "./routes/artworkRoutes.js";

//init express
const app = express();

//use express json
app.use(express.json());

//use cors - lets the backend connect to the front end
app.use(cors());

//use router
app.use(userRouter);
app.use(artworkRouter);

//PORT
app.listen(5000, () => {
  console.log("Server running successfully");
});
