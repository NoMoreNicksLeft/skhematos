-- Video game console table (specific model numbers).
create table if not exists video_games.machines (
    id              uuid default uuid_generate_v4() primary key,
    platform        uuid references video_games.platforms not null,
    long_name       text not null,
    nickname        text,
    model_number    text,
    producer        uuid references common.companies,
    designer        uuid references common.companies,
    manufacturer    uuid references common.companies,
    market          text references common.iso_3166_1(alpha3_code),
    status          video_games.machine_status,
    released        common.flexidate,
    clock           text constraint "Clock signals are measured in Hertz (Hz) or multiples thereof." 
        check (clock ~ '^\d+(\.\d+)?(K|M|G)Hz$'),
    ram             text constraint "RAM values are powers-of-2 integers plus unit, one of B/K/M/G. e.g. 512K."
        check (ram ~ '^\d+(K|M|G|T)?bytes$'),
    video_standard  video_games.video_standard,
    resolutions     video_games.video_resolution[],
    media           video_games.media_type[] not null,
    created         timestamp without time zone default (now() at time zone 'utc')
);
comment on table video_games.machines is 'A specific model of video game console (or other type of machine).';

-- Postgres doesn't have (and won't be getting for some time) array foreign keys, so we need a many-to-many table.
create table if not exists video_games.machine_chip (
    machine uuid references video_games.machines,
    chip    uuid references video_games.chips,
    role    video_games.chip_role,
    n       integer constraint "Chips can only exist in positive quantities." check (n > 0),
    created timestamp without time zone default (now() at time zone 'utc'),
    unique (machine, chip, role)
);
comment on table video_games.machine_chip is 'Mapping integrated circuits to game consoles.';
