create or replace view v_nbu_check_credit as
select distinct c.rnk ,case when  f.rnk is not null then 1
                            when u.rnk is not null then 2
                            end check_person,
                        case when c.numdog like '%¡œ %' then 2
                             else 1 end type_credit,c.kf,c.nd
from core_credit c
left join (select rnk from core_person_fo)  f on f.rnk=c.rnk
left join (select rnk from core_person_uo)  u on u.rnk=c.rnk;
/