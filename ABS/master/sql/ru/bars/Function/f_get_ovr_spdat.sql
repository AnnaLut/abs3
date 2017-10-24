
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_ovr_spdat.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_OVR_SPDAT (p_dat date, p_nd number, p_par number)
--==================================
-- Процедура, що повертає дату виникнення суми простроченої заборгованості  ОВЕРДРАФТІВ
--(непогашеної на звітну дату p_dat) за основним боргом (p_par = 0) або відсотками (p_par = 1)
--за договором p_nd
--==================================
--              08/04/2014
--==================================
return date is
   l_dat   date;
   l_Di_   number;
   l_ss    number := 0;
   l_ost number:=null;
   l_title varchar2(30) := 'CCK: F_GET_OVR_SPDAT -';
     right_now TIMESTAMP (4) := CURRENT_TIMESTAMP;
begin

   for d in (select s.fdat, s.dos,  s.acc
               from saldoa s
              where acc = (select decode(p_par, 1,acc_2069,acc_2067) from  acc_over where sos=1 and nd=p_nd)
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
 
PROMPT *** Create  grants  F_GET_OVR_SPDAT ***
grant EXECUTE                                                                on F_GET_OVR_SPDAT to RCC_DEAL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_ovr_spdat.sql =========*** En
 PROMPT ===================================================================================== 
 