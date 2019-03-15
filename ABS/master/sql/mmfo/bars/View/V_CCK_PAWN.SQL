
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_cck_pawn.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_PAWN ("ACC", "ND", "IDZ", "KF", "PAWN", "NDZ") AS 
  select distinct c.acc, c.nd, c.idz, c.kf, p.pawn, p.ndz
  from cc_accp c, pawn_acc p
  where c.acc = p.acc
;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_cck_pawn.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 