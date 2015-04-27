-- The ISO 3166-1 standard for naming countries and geographical regions.
create table if not exists common.iso_3166_1 (
    english_name text,
    alpha2_code  text constraint "Alpha-2 codes must consist of exactly 2 uppercase letters."
        check (alpha2_code ~ '^[A-Z]{2}$') unique,
    alpha3_code  text constraint "Alpha-3 codes must consist of exactly 3 uppercase letters."
        check (alpha3_code ~ '^[A-Z]{3}$') unique,
    numeric_code text constraint "Numeric codes must consist of exactly 3 digits."
        check (numeric_code ~ '^\d{3}$') unique
);
comment on table common.iso_3166_1 is 'ISO standard codes for countries and geographical regions.';
