
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_cck_spdat.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_CCK_SPDAT (p_dat date, p_nd number, p_par number)
--==================================
-- Процедура, що повертає дату виникнення суми простроченої заборгованості
--(непогашеної на звітну дату p_dat) за основним боргом (p_par = 0) або відсотками (p_par = 1)
--за договором p_nd
--==================================
--              08/01/2013  - оптимизирована по скорости выполнения (сильно!)
--    ver.2.0   27/12/2012
--==================================
return date is
   l_dat   date;
   l_Di_   number;
   l_ss    number := 0;
   l_ost number:=null;
   l_title varchar2(30) := 'CCK: F_GET_CCK_SPDAT -';
     right_now TIMESTAMP (4) := CURRENT_TIMESTAMP;
begin

   for d in (select s.fdat, s.dos,  s.acc
               from saldoa s
              where acc = (select acc from
                                     (select a.acc acc
                                       from accounts a, nd_acc n
                                       where n.nd = p_nd
                                                 and n.acc = a.acc
                                                and a.tip = decode(p_par, 1,'SPN','SP ')
                                                and (a.dazs is null or a.dazs > p_dat)
                                               and a.daos <= p_dat order by  a.acc desc
                                      )
                                        where fost(acc, p_dat)!=0 and rownum=1
                               )
                and s.fdat <= p_dat
              order by s.fdat desc
              )
     loop
     null;

    --   logger.info ('Nov2='||to_char(CURRENT_TIMESTAMP-right_now));
       l_ss := l_ss + d.dos;

      --   bars_audit.trace('%s Дог.реф=%s:l_ss=%s,d.dos=%s', l_title,to_char(p_nd),to_char(l_ss),to_char(d.dos));
       if l_ost is null then l_ost:= fost(d.acc, p_dat); end if;
       if l_ss >= abs(l_ost) then l_dat := d.fdat; exit; end if;

     end loop;

-- logger.info ('Nov3='||to_char(CURRENT_TIMESTAMP-right_now));

return l_dat;

end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_CCK_SPDAT ***
grant EXECUTE                                                                on F_GET_CCK_SPDAT to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_CCK_SPDAT to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_cck_spdat.sql =========*** En
 PROMPT ===================================================================================== 
 