-- We need a more forgiving date type. Sometimes only years are known, other times year+month.
create domain common.flexidate as text
    constraint bad_date_format check 
        (value ~ '^[12]\d\d\d-(x|xx|0[1-9]|1[012]|[1-9])-(x|xx|[1-9]|0[1-9]|1[0-9]|2[0-9]|3[01])$')
    constraint month_null_day_must_be_null check 
        (value !~ '-(x|xx)-\d{1,2}$'); -- If the month is null, the day must be null as well.
comment on domain common.flexidate is 'A date type (format yyyy-mm-dd) that allows null months/days, eg 1992-04-xx.';

-- Need an enum for URIs to describe their source.
create type common.web_type as enum ('home',
                                     'opencorporates',
                                     'wikipedia',
                                     'amazon',
                                     'wayback',
                                     'youtube');
-- ALTER TYPE common.web_type ADD VALUE 'new_value' AFTER 'old_value';
comment on type common.web_type is 'A list of possible values that describe a uri/link.';

-- Need an enum for images to describe their use.
create type common.image_type as enum ('cabinet-marquee',
                                       'cabinet-control-panel',
                                       'cabinet-bezel',
                                       'cabinet-side-right',
                                       'cabinet-side-left',
                                       'cabinet-cocktail',
                                       'cabinet-instruction-sticker',
                                       'cabinet-kickplate',
                                       'cabinet-other',
                                       'brochure',
                                       'logo',
                                       'box-front',
                                       'box-back',
                                       'disk-label',
                                       'cart-label-front',
                                       'cart-label-side',
                                       'fanart',
                                       'screenshot',
                                       'poster',
                                       'banner');
comment on type common.image_type is 'A list of possible values that describe an image.';

-- Need an enum for images to describe their provenance.
create type common.image_source_type as enum ('scan','photograph','original-art','recreated','cc-licensed','amazon');
comment on type common.image_source_type is 'A list of possible values that describe the provenance of an image.';
