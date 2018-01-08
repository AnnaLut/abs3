PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_BV_BALANS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_BV_BALANS ***

  CREATE OR REPLACE PROCEDURE BARS.P_BV_BALANS (p_dat01 date) IS

/* ������ 2.0  31-07-2017
   BV �� 351 ��������� = �������
   -------------------------------------
 1) 31-07-2017  - ������������ �� ��� ��������� � ������ ������� fin=1
                                 
*/

 l_bv    rez_cr.bv%type; l_bvq  rez_cr.bvq%type;
 l_dat31 date;

begin
   l_dat31 := Dat_last_work ( p_dat01 - 1 ) ;
   for k in (select  a.ostc - a.bv del, a.*
             from (select acc,sum(bv) bv, - ost_korr(acc,l_dat31,null,'2068')/100 ostc
                   from rez_cr where fdat = p_dat01 group by acc) a
             where bv<>ostc)
   LOOP
      for r in (select rowid rw, bv, kv, ead, eadq, cr, crq, nvl(pd,0) pd, decode(tipa,17,1,21,1,nvl(lgd,0)) lgd, tipa from rez_cr 
                where  fdat = p_dat01  and acc = k.acc order by fin,bv)
      LOOP
         l_bv  := greatest(r.bv + k.del,0);
         l_bvq := p_icurval(r.kv,l_bv*100,l_dat31)/100;
         k.del := k.del + (r.bv - l_bv);
         if r.ead > l_bv or r.tipa in (17,21) THEN 
            r.ead  := l_bv;                  r.eadq := l_bvq; 
            r.cr   := r.ead * r.pd *r.LGD;   r.crq  := p_icurval(r.kv,r.cr*100,l_dat31)/100;
         end if;
         update rez_cr set bv = l_bv, bvq = l_bvq, ead = r.ead, eadq = r.eadq, cr = r.cr, crq = r.crq where rowid = r.rw;
         if k.del = 0 THEN   exit; end if;
      end loop;
   end loop;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_BV_BALANS.sql =========*** End *
PROMPT ===================================================================================== 
