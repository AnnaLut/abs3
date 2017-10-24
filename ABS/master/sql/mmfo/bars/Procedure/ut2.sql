PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/UT2.sql =========*** Run *** =====
PROMPT ===================================================================================== 

PROMPT *** Create  procedure UT2 ***

CREATE OR REPLACE PROCEDURE BARS.UT2 ( p_dat01 date ) is l_di number ;     

/*
 Процедура урегулирования дисконта/невизнаних доходів для договора в разных валютах
 Версия 1.0 16-06-2017


*/

dat31_     date  := DAT_LAST_WORK (p_dat01 - 1);     -- новая процедура последний рабочий день месяца
l_commit   number:= 0 ;

begin
   l_commit := 0 ;
   for k in (select nd,kv,sum( decode (sign( bv),1, diskont, 0 )) + sum(decode(sign( bv),-1,bv, 0)) del
             from nbu23_rez where fdat = p_dat01  and id like 'CCK2%'
             group by nd, kv having sum(decode(sign(bv),1,diskont,0)) + sum(decode(sign(bv),-1,bv,0)) <> 0
            )
   loop
      for k1 in (select  rowid RI, pv, diskont, rez23 , tip from nbu23_rez
                 where fdat = p_dat01  and id like 'CCK2%' and nd = k.nd and kv = k.kv and bv >0 and diskont > 0
                 order by decode ( tip, 'SPN', 1, 'SP ', 2, 'SN ',3, 4)
                )
      loop

         if k.del > 0 then l_di := - least ( k1.diskont,  k.del);
         else              l_di :=   least ( k1.rez23,   -k.del);
         end if ;

         update nbu23_rez set diskont  = k1.diskont + l_di --, rez23 = k1.rez23 - l_di,
                              --rezq23   = gl.p_icurval ( k.kv, (k1.rez23 - l_di)*100, dat31_ ) / 100
                where rowid = k1.RI;

         k.del := k.del + l_di;

         l_commit :=  l_commit + 1 ;
         If l_commit >= 5000 then  commit;  l_commit:= 0 ;  end if;
      end loop; -- k1
   end loop ; --k
end ut2;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/UT2.sql =========*** End *** =====
PROMPT ===================================================================================== 
