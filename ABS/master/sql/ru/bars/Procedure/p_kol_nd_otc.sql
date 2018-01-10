PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/p_kol_nd_otc.sql =========*** Run *** ======
PROMPT ===================================================================================== 

PROMPT *** Create  procedure p_kol_nd_otc ***

  CREATE OR REPLACE PROCEDURE BARS.p_kol_nd_otc (p_dat01 date) IS

/* Версия 1.0  01-01-2018
   к-ть днів на дату по договору
*/

l_kol integer :=0;

begin
   z23.to_log_rez (user_id , 13 , p_dat01 ,'ПОЧАТОК Кількість днів (OTC)');
   --p_BLOCK_351(p_dat01);
   --delete from ND_kol_otc where fdat = p_dat01;
   pul_dat(to_char(p_dat01,'dd-mm-yyyy'),'');
   p_kol_deb_otc(p_dat01, l_kol,0);
   p_kol_deb_otc(p_dat01, l_kol,1);
   commit;
   p_kol_cck_otc(p_dat01, l_kol);
   commit;
   p_kol_nd_bpk_otc(p_dat01, l_kol); -- 0 - W4+bpk
   commit;
   p_kol_nd_mbdk_otc(p_dat01, l_kol);
   commit;
   p_kol_nd_over_otc(p_dat01, l_kol);
   commit;
   p_kol_cp_otc(p_dat01, l_kol);
   commit;
   z23.to_log_rez (user_id , -13 , p_dat01 ,'КІНЕЦЬ Кількість днів (OTC)');
END;
/
show err;

PROMPT *** Create  grants  CR ***
grant EXECUTE   on p_kol_nd_otc  to BARSUPL;
grant EXECUTE   on p_kol_nd_otc  to BARS_ACCESS_DEFROLE;
grant EXECUTE   on p_kol_nd_otc  to RCC_DEAL;
grant EXECUTE   on p_kol_nd_otc  to START1;
grant EXECUTE   on p_kol_nd_otc  to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CR.sql =========*** End *** ======
PROMPT ===================================================================================== 
