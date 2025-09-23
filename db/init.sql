CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO users (name) VALUES ('Zoya'), ('Malik'), ('DevOps Engineer');
