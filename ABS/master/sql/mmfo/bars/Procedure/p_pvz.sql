

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_PVZ.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_PVZ ***

  CREATE OR REPLACE PROCEDURE BARS.P_PVZ (p_dat01 date) IS

/* Версия 1.0 01-02-2017
   Заполнение PVZ в TMP_REZ_OBESP
   -------------------------------------
*/


l_dat31 date;

l_pvz  number;  l_pvzq  number;  l_kl_351 number;

begin

   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца

   for k in ( select t.rowid rw, t.* from tmp_rez_obesp23 t  where t.dat = p_dat01  )
   LOOP
      begin
         select kl_351 into l_kl_351 from rez_cr where fdat= p_dat01 and acc = k.accs and pawn = k.pawn;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_kl_351 := 0;
      end;
      --logger.info('PVZ-0 : k.sall = ' || k.sall || 'k.sall = ' || L_kl_351) ;
      l_pvz  := round(k.sall * L_kl_351);
      --logger.info('PVZ-1 : l_pvz = ' || l_pvz ) ;
      l_pvzq := round(p_icurval(k.kv,l_pvz,l_dat31));
      --logger.info('PVZ-2 : l_pvzq= ' || l_pvzq ) ;

      update tmp_rez_obesp23 set s = l_pvz, sq = l_pvzq, pvz = l_pvz, pvzq = l_pvzq, k = l_kl_351 where rowid=k.rw;
   end loop;


   for k in (select y.acc, y.pvz - x.s del, x.kv
             from  (select kv,accs,sum(pvz) s,sum(pvzq) sq from tmp_rez_obesp23 where dat =p_dat01 group by accs,kv) x,
                   (select kv,acc,pvz*100 pvz,pvzq*100 pvzq from nbu23_rez where fdat =p_dat01 and pvz<>0) y
             where  x.accs = y.acc and x.s <> y.pvz
            )
   LOOP
      for r in (select rowid rw, pvz, kv from tmp_rez_obesp23 where  dat = p_dat01  and accs = k.acc and kv=k.kv order by pvz desc)
      LOOP
         l_pvz  := r.pvz + k.del;
         l_pvzq := p_icurval(r.kv,l_pvz,l_dat31);
         update tmp_rez_obesp23 set pvz = l_pvz, pvzq = l_pvzq, s = l_pvz, sq = l_pvzq where rowid = r.rw;
         exit;
      end loop;
   end loop;

end;
/
show err;

PROMPT *** Create  grants  P_PVZ ***
grant EXECUTE                                                                on P_PVZ           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_PVZ           to RCC_DEAL;
grant EXECUTE                                                                on P_PVZ           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_PVZ.sql =========*** End *** ===
PROMPT ===================================================================================== 
