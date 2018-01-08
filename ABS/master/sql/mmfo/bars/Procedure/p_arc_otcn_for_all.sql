

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ARC_OTCN_FOR_ALL.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ARC_OTCN_FOR_ALL ***

  CREATE OR REPLACE PROCEDURE BARS.P_ARC_OTCN_FOR_ALL 
    is
   l_date        date;
   l_max_date    date;
   l_mode        number := 2;
   l_curr_branch branch.branch%type;
   l_trace varchar2(1000) := 'p_arc_otcn_for_all_ru:' ;
begin
   l_date :=  trunc(sysdate);
   bars_audit.info(l_trace||' старт выполнения накопления для A7 для всех РУ');

   l_curr_branch :=  sys_context('bars_context','user_branch');

   if to_number(to_char(l_date, 'dd'))  in (1, 11, 21) then
      select max(fdat) into l_max_date
      from fdat where fdat < l_date;

      for c in (select kf from mv_kf) loop
         bars_audit.info(l_trace||' старт выполнения для '||c.kf);
         bc.go('/'||c.kf||'/');
         bars.p_arc_otcn(l_max_date, l_mode);
         commit;
      end loop;

      bc.go(l_curr_branch);
    end if;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ARC_OTCN_FOR_ALL.sql =========**
PROMPT ===================================================================================== 
