-- Business link table.
create table if not exists common.business_web_links (
    fkey    uuid references common.business_entities,
    t       text default 'common.business_entities' check (t = 'common.business_entities')
) inherits (common.web_links);
comment on table common.business_web_links is 'The official website of a business entity.'
