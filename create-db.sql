CREATE TABLE message (
  ID integer NOT NULL,
  MESSAGE varchar(30) NOT NULL,
  PRIMARY KEY  (ID)
);

INSERT INTO message (ID, MESSAGE) VALUES
	(0, 'It works!'),
	(1, 'Hello from PostgreSQL');

