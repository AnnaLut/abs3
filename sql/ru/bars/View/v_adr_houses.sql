create or replace view v_adr_houses as
select "HOUSE_ID",
       "STREET_ID",
       "DISTRICT_ID",
       "HOUSE_NUM",
       "HOUSE_NUM_ADD",
       case when instr(t.house_num_add,'/')=0 and instr(t.house_num_add,',')=0 and t.house_num_add is not null then HOUSE_NUM||'-'||HOUSE_NUM_ADD
            when instr(t.house_num_add,'/')=1 or instr(t.house_num_add,',')=1 then HOUSE_NUM||HOUSE_NUM_ADD
            else HOUSE_NUM
       end "HOUSE_NUM_FULL",
       "POSTAL_CODE",
       "LATITUDE",
       "LONGITUDE"
from ADR_HOUSES t;

GRANT SELECT ON bars.v_adr_houses TO BARS_ACCESS_DEFROLE;
