-- Company table.
create table if not exists common.companies (
    founded        common.flexidate,
    extinction     common.flexidate,
    t              text default 'common.companies' check (t = 'common.companies'),
    primary key (id)
) inherits (common.business_entities);
comment on table common.companies is 'A business entity that is specifically a company, corporation, or similar legally recognized operation.'
