CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL
);

CREATE TABLE labels (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL
);

CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publish_date DATE NOT NULL,
    archieved BOOLEAN NOT NULL DEFAULT FALSE,
    genre_id INTEGER REFERENCES genres(id),
    author_id INTEGER REFERENCES authors(id),
    label_id INTEGER REFERENCES labels(id)
);

CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publish_date DATE NOT NULL,
    publisher VARCHAR(255) NOT NULL,
    cover_state VARCHAR(255) NOT NULL,
    archieved BOOLEAN NOT NULL DEFAULT FALSE,
    genre_id INTEGER REFERENCES genres(id),
    author_id INTEGER REFERENCES authors(id),
    label_id INTEGER REFERENCES labels(id),
    item_id INTEGER REFERENCES items(id)
);

CREATE TABLE music_albums (
    id SERIAL PRIMARY KEY,
    on_spotify BOOLEAN NOT NULL DEFAULT FALSE,
    publish_date DATE NOT NULL,
    archieved BOOLEAN NOT NULL DEFAULT FALSE,
    genre_id INTEGER REFERENCES genres(id),
    author_id INTEGER REFERENCES authors(id),
    label_id INTEGER REFERENCES labels(id),
    item_id INTEGER REFERENCES items(id)
);

CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    multiplayer BOOLEAN NOT NULL DEFAULT FALSE,
    publish_date DATE NOT NULL,
    last_played DATE NOT NULL,
    archieved BOOLEAN NOT NULL DEFAULT FALSE,
    genre_id INTEGER REFERENCES genres(id),
    author_id INTEGER REFERENCES authors(id),
    label_id INTEGER REFERENCES labels(id),
    item_id INTEGER REFERENCES items(id)
);