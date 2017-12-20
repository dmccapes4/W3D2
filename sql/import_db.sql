DROP TABLE IF EXISTS  users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS  questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS  question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS  replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  parent_id INTEGER,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS  question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
('Paul', 'Ryan'),
('Dylan', 'McCapes');

INSERT INTO
  questions (title, body, user_id)
VALUES
('How do databases work?', 'I don''t get it', (SELECT id FROM users WHERE fname = 'Paul')),
('Databases on assessments', 'How much of this stuff is relevant for the assessments?',
(SELECT id FROM users WHERE fname = 'Dylan'));

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  (2, 1),
  (1, 2),
  (2, 2);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (2, 2),
  (2, 1),
  (1, 2);

INSERT INTO
  replies (body, user_id, parent_id, question_id)
VALUES
('I hope you do get it, cuz you''re my partner', 2, NULL, 1),
('No, still don''t get it', 1, 1, 1);
