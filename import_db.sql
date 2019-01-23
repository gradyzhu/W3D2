PRAGMA foreign_keys = ON;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  
  FOREIGN KEY (users_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  FOREIGN KEY (questions_id) REFERENCES questions(id),
  FOREIGN KEY (users_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,

  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (users_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE questions_likes (
  id INTEGER PRIMARY KEY,

  FOREIGN KEY(users_id) REFERENCES users(id),
  FOREIGN KEY(users_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Bobby', 'Flay'),
  ('Kevin', 'Yoni');

INSERT INTO
  questions (title, body)
VALUES
  ('?!?', 'What is the lethal dosage of caffeine?'),
  ('HELP...please', 'How to write SQL code?!');


