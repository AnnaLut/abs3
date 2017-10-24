

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_RATES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_RATES ***

  CREATE OR REPLACE PROCEDURE BARS.P_RATES (p_sdat   varchar2, -- dd/mm/yyyy
                                     p_kv     number  ,
                                     p_bsum   number  ,
                                     p_rate_o number)
IS
  l_dat    DATE;
BEGIN
  l_dat := to_date(p_sdat,'DD/MM/YYYY');
  for k in (select tobo branch
            from   tobo
            where  tobo like sys_context('bars_context','user_branch_mask')
            )
  loop
    begin
      update cur_rates$base
      set    rate_o=p_rate_o,
             bsum=p_bsum    ,
             official='Y'
      where  vdate=l_dat and
             kv=p_kv     and
             branch=k.branch;
      if sql%rowcount=0 then
        insert
        into   cur_rates$base (kv    ,
                               vdate ,
                               bsum  ,
                               rate_o,
                               branch,
                               official)
                       values (p_kv    ,
                               l_dat   ,
                               p_bsum  ,
                               p_rate_o,
                               k.branch,
                               'Y');
      end if;
--    для размеченных "наперёд" коммерческих курсов меняем оффициальный курс
      update cur_rates$base
      set    rate_o=p_rate_o          ,
             bsum=p_bsum              ,
             rate_b=rate_b*p_bsum/bsum,
             rate_s=rate_s*p_bsum/bsum
      where  vdate between l_dat+1 and l_dat+5 and
             kv=p_kv                           and
             branch=k.branch                   and
             official='N';
   -- exception when others then
          -- raise_application_error(-20000, 'l_dat'||to_date(p_sdat,'DD/MM/YYYY')||'  -- '||k.branch||'   --'||p_kv);
    end;
  end loop;
END;
/
show err;

PROMPT *** Create  grants  P_RATES ***
grant EXECUTE                                                                on P_RATES         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_RATES         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_RATES.sql =========*** End *** =
PROMPT ===================================================================================== 
