DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;

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
  user_id INTEGER NOT NULL,
  
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,

  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
  users (id, fname, lname)
VALUES
  (1, 'Bobby', 'Flay'),
  (2, 'Kevin', 'Yoni');
INSERT INTO
  questions (title, body, user_id)
VALUES
  ('?!?', 'What is the lethal dosage of caffeine?', (SELECT id FROM users WHERE fname = "Bobby")),
  ('HELP...please', 'How to write SQL code?!', (SELECT id FROM users WHERE fname = "Kevin"));
INSERT INTO
  replies (id, body, user_id, question_id, parent_reply_id)
VALUES
  (1, 'A lot', 1, 1, NULL),
  (2, 'Sorry dude idk RIP', 2, 2, NULL);
INSERT INTO
  question_follows (id, user_id, question_id)
VALUES
  (1, 1, 1),
  (2, 2, 1);