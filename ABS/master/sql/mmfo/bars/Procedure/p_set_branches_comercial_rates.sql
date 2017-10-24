

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SET_BRANCHES_COMERCIAL_RATES.sql
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SET_BRANCHES_COMERCIAL_RATES ***

  CREATE OR REPLACE PROCEDURE BARS.P_SET_BRANCHES_COMERCIAL_RATES 
is
begin
  if(tobopack.get_branch != '/') then
     raise_application_error(-20001,'Виконання процедури дозволено лише користувачам ЦА');
  end if;
  begin
    for c in (select r.*
                from cur_rates$base r
                where r.branch = tobopack.get_branch
                  and r.vdate = gl.bd
                  and r.rate_b is not null
                  and r.rate_s is not null) loop
      update cur_rates$base cr set cr.rate_b = c.rate_b,
                                                 cr.rate_s = c.rate_s
      where cr.kv = c.kv
        and cr.vdate = c.vdate
        and cr.branch !=  tobopack.get_branch;
    end loop;
  exception when others then
    rollback;
  end;
end;
/
show err;

PROMPT *** Create  grants  P_SET_BRANCHES_COMERCIAL_RATES ***
grant EXECUTE                                                                on P_SET_BRANCHES_COMERCIAL_RATES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SET_BRANCHES_COMERCIAL_RATES.sql
PROMPT ===================================================================================== 
