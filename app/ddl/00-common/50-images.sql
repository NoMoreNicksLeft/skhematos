-- The images table.
create table if not exists common.images (
    id         serial primary key,
    image_type common.image_type not null,
    mime_type  text constraint unsupported_mime 
        check (mime_type in ('image/jpeg','image/png','image/gif')) not null,
    source     common.image_source_type,
    path       text unique,
    created    timestamp without time zone default (now() at time zone 'utc')
);
comment on table common.images is 'Images relevant to the various meta databases hosted at skhematos.com.';
