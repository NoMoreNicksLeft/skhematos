-- The links table.
create table if not exists common.web_links (
    t         text,
    fkey      uuid,
    id        serial primary key,
    link_type common.web_type,
    uri       text,
    created   timestamp without time zone default (now() at time zone 'utc'),
    constraint "Not a valid http link." check (
        uri ~ '^http(s)?:\/\/.+?'
    ),
    constraint "Not a valid opencorporates URI." check (
        case when link_type = 'opencorporates' 
            then (uri ~ '^https://opencorporates.com/companies/[a-z_]{2,5}/[A-Z0-9]+$') 
            else true
        end
    ),
    constraint "Not a valid Amazon URI." check (
        case when link_type = 'amazon' then (uri ~ '^http://www.amazon.[a-z.]+/gp/product/[0-9A-Z]{10}') else true end
    ),
    constraint "Not a valid Wikipedia URI." check (
        case when link_type = 'wikipedia' then (uri ~ '^http://[a-z][a-z].wikipedia.org/wiki/.+$') else true end
    ),
    constraint "Not a valid Wayback URI." check (
        case when link_type = 'wayback' then (uri ~ '^http://wayback.archive.org/web/\d{14}/http://.+') else true end
    ),
    constraint "Not a valid Youtube URI." check (
        case when link_type = 'youtube' then (uri ~ '^http://www.youtube.com/watch\?v=.+') else true end
    )
);
comment on table common.web_links is 'Web URIs relevant to the various meta databases hosted at skhematos.com.';
