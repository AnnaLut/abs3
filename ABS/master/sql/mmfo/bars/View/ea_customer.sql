create or replace view ea_customer as
select c.rnk, c.name_last||' '||c.name_first||' '||c.name_middle nmk, c.okpo, p.psp_issued   pdate, c.birthday bday
from bars.fsc_CUSTOMER c, bars.fsc_customer_passport p
where c.custype    = 3  -- Фізична особа
  and p.rnk (+)    = c.rnk;
