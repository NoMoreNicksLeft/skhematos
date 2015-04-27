-- Person (business entity) table.
create table if not exists common.business_persons (
    birth          date,
    t              text default 'common.persons' check (t = 'common.persons'),
    primary key (id)
) inherits (common.business_entities);
comment on table common.business_persons is 'A business entity who is a sole proprietor or otherwise operates under his/her own name.'
