-- Various chips, asics, and semiconductors used by video game machines.
create table if not exists video_games.chips (
    id           uuid default uuid_generate_v4() primary key,
    manufacturer uuid references common.companies,
    licensee     uuid references common.companies,
    designer     uuid references common.companies,
    model_number text,
    description  text,
    process      text constraint "Process values are integers plus unit, a (microscopic) distance. e.g. 90nm."
        check (process ~ '^\d+(µm|nm)$'),
    transistors  bigint constraint "The number of transistors is a positive number." check (transistors > 0),
    created      timestamp without time zone default (now() at time zone 'utc')
);
comment on table video_games.chips is 'A specific integrated circuit used in one or another video game machine.'
