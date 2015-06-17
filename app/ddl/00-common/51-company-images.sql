-- Company images table.
create table if not exists common.company_images (
    fkey    uuid references common.companies,
    t       text default 'common.companies' check (t = 'common.companies')
) inherits (common.images);
comment on table common.company_images is 'Logos or other pertinent images for a company.'
