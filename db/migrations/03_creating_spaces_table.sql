\c makersbnb
CREATE TABLE spaces(id SERIAL PRIMARY KEY, space_name VARCHAR(60), description VARCHAR(60), price int, availability_from VARCHAR(60), availability_to VARCHAR(60), user_id int);
\c makersbnb_test
CREATE TABLE spaces(id SERIAL PRIMARY KEY, space_name VARCHAR(60), description VARCHAR(60), price int, availability_from VARCHAR(60), availability_to VARCHAR(60), user_id int);