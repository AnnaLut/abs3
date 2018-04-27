

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_PAR_9200.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_PAR_9200 ***

  CREATE OR REPLACE PROCEDURE BARS.P_PAR_9200 (p_dat01  date    , p_mode  integer , p_rnk  integer,
                                       p_nls    varchar2, p_kv    number  , p_fin  number ,
                                       p_VKR    VARCHAR2, p_comm  varchar2, p_PD   number, p_NOT_LIM number) IS

/* Версия 1.0  25-10-2017
   p_mode = 1 - UPDATE
          = 2 - INSERT
          = 3 - DELETE
*/

l_9200   REZ_PAR_9200%rowtype;

begin
   l_9200.rnk     := p_rnk;
   l_9200.fin     := p_fin;
   l_9200.vkr     := p_vkr;
   l_9200.comm    := p_comm;
   l_9200.pd      := p_pd;
   l_9200.kf      := sys_context('bars_context','user_mfo');
   l_9200.fdat    := p_dat01;
   l_9200.not_lim := p_not_lim;
   begin
      select acc into l_9200.nd from accounts where nls = p_nls and kv = p_kv;
   EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
   end;
   if    p_mode = 1 THEN  update REZ_PAR_9200 set   rnk = l_9200.rnk, nd = l_9200.nd, fin = l_9200.fin, vkr = l_9200.vkr, comm = l_9200.comm, pd = l_9200.pd, not_lim = l_9200.not_lim 
                          where rnk = p_rnk and  nd = l_9200.nd and fdat = p_dat01;
   elsif p_mode = 2 THEN  insert into REZ_PAR_9200 values l_9200;
   else                   delete from REZ_PAR_9200 where rnk = l_9200.rnk and  nd = l_9200.nd and fdat = p_dat01;
   end if;

end;
/
show err;

PROMPT *** Create  grants  P_PAR_9200 ***
grant EXECUTE                                                                on P_PAR_9200      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_PAR_9200      to RCC_DEAL;
grant EXECUTE                                                                on P_PAR_9200      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_PAR_9200.sql =========*** End **
PROMPT ===================================================================================== 
