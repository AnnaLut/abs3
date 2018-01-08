

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_W_EPS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_W_EPS ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_W_EPS ("NPP", "FDAT", "SS1", "SDP", "SS2", "SN2", "S") AS 
  SELECT (m.FDAT - x.DAT1 + 1) npp,
       m.FDAT,
       m.SS1,
       m.SDP,
       m.SS2,
       m.SN2,
       (m.SS1 + m.SN2 + m.SDP + m.SS2) S
  from (select *
          from CC_many
         where nd = TO_NUMBER(pul.Get_Mas_Ini_Val('ND'))) m,
       (select nd, min(fdat) DAT1
          from CC_many
         where nd = TO_NUMBER(pul.Get_Mas_Ini_Val('ND'))
         group by nd) x
 where m.nd = x.nd
;

PROMPT *** Create  grants  CC_W_EPS ***
grant SELECT                                                                 on CC_W_EPS        to BARSREADER_ROLE;
grant SELECT                                                                 on CC_W_EPS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_W_EPS        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_W_EPS.sql =========*** End *** =====
PROMPT ===================================================================================== 
