\set ON_ERROR_STOP 1
BEGIN;

CREATE TABLE artist_credit_name_display_mode ( -- replicate
    id                  SERIAL,
    name                VARCHAR(255) NOT NULL,
    parent              INTEGER, -- references artist_credit_name_display_mode.id
    child_order         INTEGER NOT NULL DEFAULT 0,
    description         TEXT,
    gid                 uuid NOT NULL
);

CREATE UNIQUE INDEX artist_credit_name_display_mode_idx_gid ON artist_credit_name_display_mode (gid);
ALTER TABLE artist_credit_name_display_mode ADD CONSTRAINT artist_credit_name_display_mode_pkey PRIMARY KEY (id);

ALTER TABLE artist_credit_name_display_mode
   ADD CONSTRAINT artist_credit_name_display_mode_fk_parent
   FOREIGN KEY (parent)
   REFERENCES artist_credit_name_display_mode(id);

INSERT INTO artist_credit_name_display_mode (id, name) VALUES (1, 'Replace', NULL, 1, "replace artist_name with artist_credit_name") RETURNING *;
INSERT INTO artist_credit_name_display_mode (id, name) VALUES (2, 'Credited As', NULL, 2, "display artist_name (credited as artist_credit_name)") RETURNING *;

ALTER TABLE artist_credit_name ADD COLUMN display_mode integer default 1;

ALTER TABLE artist_credit_name
   ADD CONSTRAINT artist_fk_display_mode
   FOREIGN KEY (display_mode)
   REFERENCES artist_credit_name_display_mode(id);

CREATE TRIGGER "reptg_artist_credit_name_display_mode"
AFTER INSERT OR DELETE OR UPDATE ON "artist_credit_name_display_mode"
FOR EACH ROW EXECUTE PROCEDURE "recordchange" ();

COMMIT;
