

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CR.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CR ***

  CREATE OR REPLACE PROCEDURE BARS.CR (p_dat01 date) IS

/* Версия 3.1 05-09-2017  29-01-2017  20-01-2017  21-12-2016
   Розрахунок кредитного ризику (Загальна)
 4) 05-09-2017 - Добавлена процедура  REZ_ND_VAL_1200(p_dat01, l_kol);
 3) 29-01-2017 - p_2401_OSBB - отдельная процедура (выполняется при выгрузке T0)
 2) 20-01-2017 - Протоколирование о начале и окончании  расчета
 1) 21-12-2016 - ОСББ --> Портфельный метод p_2401_OSBB
*/
l_kol integer;

begin
   z23.to_log_rez (user_id , 13 , p_dat01 ,'ПОЧАТОК (CR) Кредитний ризик 351 ');
   p_BLOCK_351(p_dat01);
   delete from rez_cr     where fdat = p_dat01;
   delete from errors_351 where fdat < p_dat01;
   pul_dat(to_char(p_dat01,'dd-mm-yyyy'),'');
   if sys_context('bars_context','user_mfo') ='300465' THEN l_kol :=1;
   else                                                     l_kol :=0;
   end if;
   -- p_2401_OSBB(p_dat01);
   -- commit;
   p_nd_open  (p_dat01);
   commit;
   p_kol_deb(p_dat01, l_kol,0);
   p_kol_deb(p_dat01, l_kol,1);
   commit;
   p_REZ_kpz(P_DAT01 );
   commit;
   p_kol_nd(p_dat01, 0, l_kol);
   commit;
   p_kol_nd_bpk(p_dat01, l_kol); -- 0 - W4+bpk
   commit;
   p_kol_nd_mbdk(p_dat01, l_kol);
   commit;
   p_kol_nd_over(p_dat01, l_kol);
   commit;
   p_kol_cp(p_dat01, l_kol);
   commit;
   REZ_ND_VAL_1200(p_dat01, l_kol);
   commit;
   deb_351(P_DAT01,1,0);
   deb_351(P_DAT01,1,1);
   commit;
   CCK_351(P_DAT01,0,1);
   commit;
   mbdk_351(P_DAT01,1);
   commit;
   cp_351(P_DAT01,1);
   commit;
   p_nbu23_cr(p_dat01);
   commit;
   z23.to_log_rez (user_id , -13 , p_dat01 ,'КІНЕЦЬ (CR) Кредитний ризик 351 ');
END;
/
show err;

PROMPT *** Create  grants  CR ***
grant EXECUTE                                                                on CR              to BARSUPL;
grant EXECUTE                                                                on CR              to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CR              to RCC_DEAL;
grant EXECUTE                                                                on CR              to START1;
grant EXECUTE                                                                on CR              to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CR.sql =========*** End *** ======
PROMPT ===================================================================================== 
