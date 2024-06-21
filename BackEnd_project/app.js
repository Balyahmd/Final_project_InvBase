require("dotenv").config();
const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;
const cors = require("cors");

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static("public"));
app.use(cors());

const routes = require("./routes");
app.use(routes);

app.listen(PORT, () => {
  console.log(`Server is runnig on port ${PORT}`);
});
