

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EDITPROPS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EDITPROPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EDITPROPS ("REF", "TT", "USERID", "NLSA", "S", "LCV_A", "VDAT", "S2", "LCV_B", "MFOB", "NLSB", "DK", "SK", "DATD", "PDAT") AS 
  SELECT o.REF,
           o.tt,
           o.userid,
           o.nlsa,
           o.s/v1.denom s,
           v1.lcv lcv_a,
           o.vdat,
           o.s2/v2.denom s2,
           v2.lcv lcv_b,
           o.mfob,
           o.nlsb,
           o.dk,
           o.sk,
           o.datd,
           o.pdat
      FROM oper o, tabval$global v1, tabval$global v2
     WHERE     o.kv = v1.kv
           AND o.kv2 = v2.kv
           AND o.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  V_EDITPROPS ***
grant SELECT                                                                 on V_EDITPROPS     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EDITPROPS.sql =========*** End *** ==
PROMPT ===================================================================================== 
