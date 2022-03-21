\c makersbnb
CREATE TABLE users(id SERIAL PRIMARY KEY, username VARCHAR(60) UNIQUE, email VARCHAR(60) UNIQUE, name VARCHAR(60), password_digest VARCHAR(60));
\c makersbnb_test
CREATE TABLE users(id SERIAL PRIMARY KEY, username VARCHAR(60) UNIQUE, email VARCHAR(60) UNIQUE, name VARCHAR(60), password_digest VARCHAR(60));