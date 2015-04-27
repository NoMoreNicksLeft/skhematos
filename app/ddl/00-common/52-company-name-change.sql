-- Business name change table.
create table if not exists common.company_name_change (
    fkey     uuid references common.companies,
    new_name text,
    as_of    common.flexidate
);
comment on table common.company_name_change is 'Name changes for companies excluding mergers or other changes in ownership.';
