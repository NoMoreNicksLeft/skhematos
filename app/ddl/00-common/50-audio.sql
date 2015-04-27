-- The audio table.
create table if not exists common.audio (
    id         serial primary key,
    path       text unique,
    created    timestamp without time zone default (now() at time zone 'utc')
);
comment on table common.audio is 'Audio clips relevant to the various meta databases hosted at skhematos.com.';
