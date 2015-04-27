-- The business_entities (parent) table.
create table if not exists common.business_entities (
    t              text,
    id             uuid default uuid_generate_v4() primary key,
    name           text,
    disambiguation text,
    created        timestamp without time zone default (now() at time zone 'utc')
);
comment on table common.business_entities is 'Business entities relevant to the various meta databases hosted at skhematos.com.';
