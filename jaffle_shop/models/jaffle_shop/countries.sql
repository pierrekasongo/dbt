-- This refers to the table created from seeds/country_codes.csv
select * from {{ ref('country_codes') }}