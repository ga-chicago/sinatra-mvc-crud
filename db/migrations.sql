DROP DATABASE IF EXISTS salty_items;
CREATE DATABASE salty_items;

\c salty_items

CREATE TABLE items(
  id SERIAL PRIMARY KEY,
  content VARCHAR(255)
);