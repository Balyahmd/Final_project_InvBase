require("dotenv").config();

module.exports = {
  development: {
    username: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    host: process.env.DB_HOST,
    dialect: "postgres",
  },
  test: {
    username: "user_test",
    password: "password_test",
    database: "database_test",
    host: "localhost",
    dialect: "postgres",
  },
  production: {
    username: "user_prod",
    password: "password_prod",
    database: "database_prod",
    host: "localhost",
    dialect: "postgres",
  },
};
