\set ON_ERROR_STOP 1
BEGIN;

DO $$
BEGIN
  PERFORM 1 FROM pg_type
  WHERE typname = 'artist_credit_name_display_mode';

  IF NOT FOUND THEN
    CREATE TYPE artist_credit_name_display_mode AS ENUM ('replace', 'credited-as');
  END IF;
END
$$;

ALTER TABLE artist_credit_name ADD COLUMN IF NOT EXISTS display_mode artist_credit_name_display_mode DEFAULT 'replace' NOT NULL;

COMMIT;
