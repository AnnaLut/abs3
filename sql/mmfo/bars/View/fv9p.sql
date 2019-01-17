create or replace view FV9P as 

SELECT COLNAME PI, SEMANTIC SI 
from META_COLUMNS 
where tabid = bars_metabase.get_tabid('PRVN_FV9') and COLNAME like 'P__' 
order by 1;

grant SELECT on FV9P       to BARS_ACCESS_DEFROLE;
