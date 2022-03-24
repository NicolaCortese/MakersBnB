\c makersbnb
CREATE TABLE bookings(id SERIAL PRIMARY KEY, space_id int, user_id int, booked_from VARCHAR(60), booked_to VARCHAR(60), created_at TIMESTAMP, accepted BOOLEAN);
\c makersbnb_test
CREATE TABLE bookings(id SERIAL PRIMARY KEY, space_id int, user_id int, booked_from VARCHAR(60), booked_to VARCHAR(60), created_at TIMESTAMP, accepted BOOLEAN);

