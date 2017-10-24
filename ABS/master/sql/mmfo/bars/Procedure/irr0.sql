

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/IRR0.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure IRR0 ***

  CREATE OR REPLACE PROCEDURE BARS.IRR0 (dat01_ DATE)  IS

zal_ras NUMBER;
zal_pr_ NUMBER;
Zprq_   NUMBER;
kv_     NUMBER;
dat31_  date;

begin

   dat31_ := Dat_last (dat01_ -4, dat01_-1 ) ;
   for k in ( select nd,rnk,sum(bv) BV,sum(pv) PV, sum(pvz) pvz,sum(zal) zal
              from nbu23_rez
              where fdat=dat01_ and id like ('MBDK%') and nvl(IRR,0)<>0
                    and nd in (111583 ,111583 	,111604 	,111641 	,111651 	,111683 	,
111710 	,111730 	,111756 	,111781 	,111798 	,
111813,111551 ,	111545 	,111550 	,111554 	,111556 	,111557 	,
111558 	,111559 	,111560 	,111656 	,111783 	,111809 	,
111626 	,111630 	,111633 	,111635 	,111639 	)
              group by nd,rnk
            )
   LOOP
      begin
         if k.zal<>0 then
            if k.BV>k.PV-k.PVZ THEN
               zal_ras:=k.BV-(k.PV-k.PVZ);
            else
               zal_ras:=0;
            end if;
            begin
               for p in (select t.*,t.ROWID RI from tmp_rez_obesp23 t,accounts a
                         where  t.accs=a.acc and a.nbs<>'9129' and
                                t.nd=k.nd and t.dat=dat01_ )
               loop
                  zal_pr_:=round(zal_ras*p.s/k.ZAL/100,2);
                  KV_    := p.kv;
                  update tmp_rez_obesp23 set zpr=zal_pr_  where rowid=p.ri;
               end loop;
            end;

            If KV_ != 980 then
               Zprq_ := gl.p_icurval (KV_, zal_ras, DAT31_) ;
            else
               Zprq_ := zal_ras;
            end if;
            update nbu23_rez set zpr=zal_ras,zprq=zprq_
            where rnk=k.rnk and nd=k.nd and zal<>0 and fdat=dat01_;
         end if;
       end;
   END LOOP;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/IRR0.sql =========*** End *** ====
PROMPT ===================================================================================== 
