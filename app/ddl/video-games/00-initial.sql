-- Drop the schema if dbClean is true.
drop schema if exists video_games cascade;

-- Create the video games schema.
create schema if not exists video_games;
comment on schema video_games is 'Metadata for video games of all varieties.';
