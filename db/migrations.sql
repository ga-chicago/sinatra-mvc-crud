DROP DATABASE IF EXISTS salty_items;
CREATE DATABASE salty_items;

\c salty_items

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  username VARCHAR(32),
  password_digest VARCHAR(60)
);

CREATE TABLE items(
  id SERIAL PRIMARY KEY,
  content VARCHAR(255),
  user_id INTEGER REFERENCES users(id)
);


