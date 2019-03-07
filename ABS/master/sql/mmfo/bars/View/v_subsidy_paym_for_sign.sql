create or replace view v_subsidy_paym_for_sign as
select o.ref
  from oper o,
       subsidy_data sd 
 where o.sos!=5
   and sd.ref = o.ref
   and not exists (select 1 
                     from oper_visa ov
                    where ov.ref = o.ref
                      and ov.groupid = 44)
   and o.pdat > sysdate - 5;

grant select on v_subsidy_paym_for_sign to bars_access_defrole;
