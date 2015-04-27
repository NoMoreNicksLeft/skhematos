-- Video game platforms table (consoles, operating systems, devices).
create table if not exists video_games.platforms (
    id          uuid default uuid_generate_v4() primary key,
    long_name   text unique,
    short_code  text check (short_code ~ '^[A-Z0-9]{2,6}$'),
    description text,
    producer    uuid references common.companies,
    nature      video_games.platform_type,
    created     timestamp without time zone default (now() at time zone 'utc')
);
comment on table video_games.platforms is 'A (sometimes loose) group of machines, virtual machines, or operating systems all capable of executing a common set of video games.'
