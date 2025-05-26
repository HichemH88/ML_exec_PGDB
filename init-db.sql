CREATE ROLE web_anon NOLOGIN;

CREATE SCHEMA api;

CREATE TABLE api.todos (
  id serial PRIMARY KEY,
  task text NOT NULL,
  done boolean NOT NULL DEFAULT false
);

GRANT USAGE ON SCHEMA api TO web_anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON api.todos TO web_anon;
