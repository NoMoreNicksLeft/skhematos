-- The platform type enum.
create type video_games.platform_type as enum (
    'Hardware',
    'Software',
    'Other'
);
comment on type video_games.platform_type is 'The type of video game platform.';

-- The video game machine status enum.
create type video_games.machine_status as enum (
    'Official',
    'Promotional',
    'Prototype',
    'Homebrew',
    'Short-run',
    'Licensed-clone',
    'Unauthorized-clone'
);
comment on type video_games.machine_status is 'The status of a video game machine.';

-- The role of a chip within a particular game machine.
create type video_games.chip_role as enum (
    'CPU',
    'Coprocessor',
    'Video',
    'Audio',
    'Physics',
    'FPGA'
);
comment on type video_games.platform_type is 'A video resolution (height, width) a console or game is capable of.';

-- Video resolutions, used both for machines and for video games themselves
create type video_games.video_resolution as (
    h integer,
    w integer
);
comment on type video_games.platform_type is 'A video resolution (height, width) a console or game is capable of.';

-- Various video standards.
create type video_games.video_standard as enum (
    'NTSC',
    'PAL',
    'SECAM',
    'CGA',
    'EGA',
    'VGA',
    'SVGA'
);
comment on type video_games.platform_type is 'The video signal used by a console or video game machine.';

-- Media types for video games.
create type video_games.media_type as enum (
    'Internal Rom',
    'Cartridge',
    'Compact (Audio) Cassette',
    '8" Floppy',
    '5¼" Floppy',
    '3½" Floppy',
    'CD-ROM',
    'DVD-ROM',
    'BD-ROM',
    'Type-in (magazine listing)'
);
comment on type video_games.platform_type is 'The media format the console or video game machine supports.';