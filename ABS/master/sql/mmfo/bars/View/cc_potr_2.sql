
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/cc_potr_2.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.CC_POTR_2 ("ID", "NAME", "K9", "IFRS", "POCI", "AIM", "CUSTTYPE") AS 
  select s.r020 || s.ob22,
       SUBSTR(s.txt, 1, 250),
       k.k9,
       k.ifrs,
       k.poci,
       cc.aim,
       cc.custtype
  from k9 k, cc_aim_2 cc, sb_ob22 s, cck_ob22 c
 where cc.k9 = k.k9
   and s.d_close IS NULL
   and s.r020 = c.nbs(+)
   and s.ob22 = c.ob22(+)
   and r020 = cc.nbs
;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/cc_potr_2.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 