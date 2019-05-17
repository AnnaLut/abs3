create or replace view v_subsidy_paym_for_sign as
select o.ref
  from oper o,
       subsidy_data sd 
 where o.sos not in (5, -1, -2)
   and sd.ref = o.ref
   and not exists (select 1 
                     from oper_visa ov
                    where ov.ref = o.ref
                      and ov.groupid = 44)
   and o.pdat > sysdate - 5
union 
select o1.ref
  from oper o1
 where o1.sos not in (5, -1, -2)
   and o1.pdat > sysdate - 5
   and o1.tt = 'SM8';

grant select on v_subsidy_paym_for_sign to bars_access_defrole;