PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/REZ_PAR_9200_ADD.sql =========*** Run **
PROMPT ===================================================================================== 

PROMPT *** Create  procedure REZ_PAR_9200_ADD ***

  CREATE OR REPLACE PROCEDURE BARS.REZ_PAR_9200_ADD (p_dat01  date) IS

/* Версия 1.0  23-04-2018
   Наполнение счетами 92..., 93...
*/

l_9200   REZ_PAR_9200%rowtype;  l_dat31 date;  sdat01_ varchar2(10);  l_cn     number; 

begin
   select count(*) into l_cn from REZ_PAR_9200 where fdat=p_dat01; 
   if l_cn>0 THEN return; end if; 
   sdat01_ := to_char( p_DAT01,'dd.mm.yyyy');
   PUL_dat(sdat01_,'');
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   for k in (select a.* from accounts a, rez_deb d 
             where a.nbs = d.nbs and d.tipa in (12, 30, 92, 93) and ost_korr(a.acc,l_dat31,null,a.nbs) < 0 )
   LOOP

      l_9200.rnk     := k.rnk;
      l_9200.fin     := null;
      l_9200.vkr     := null;
      l_9200.comm    := null;
      l_9200.pd      := null;
      l_9200.kf      := sys_context('bars_context','user_mfo');
      l_9200.fdat    := p_dat01;
      l_9200.nd      := k.acc;
      l_9200.not_lim := 0;

      insert into REZ_PAR_9200 values l_9200;
   end loop;
end;
/
show err;

PROMPT *** Create  grants  REZ_PAR_9200_ADD ***
grant EXECUTE      on REZ_PAR_9200_ADD      to BARS_ACCESS_DEFROLE;
grant EXECUTE      on REZ_PAR_9200_ADD      to RCC_DEAL;
grant EXECUTE      on REZ_PAR_9200_ADD      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_PAR_9200.sql =========*** End **
PROMPT ===================================================================================== 
