

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_KOL_ALL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_KOL_ALL ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_KOL_ALL ("ND", "CC_ID", "SDATE", "O9819", "T9819", "GOLD", "CRDVD", "SOS", "CRDND", "REF_NOW", "NLSA", "NAM_A", "NLSB", "NAM_B") AS 
  SELECT d.nd, d.cc_id, d.sdate,
          (SELECT txt FROM operw, cc_kol_o9819  WHERE kod = VALUE AND tag = 'O9819' AND REF = r.REF) o9819,
          (SELECT txt FROM operw, cc_kol_tblank WHERE tblank = VALUE AND tag = 'T9819' AND REF = r.REF) t9819,
          (SELECT VALUE FROM operw WHERE tag = 'GOLD' AND REF = r.REF) gold,
          (SELECT nvl(VALUE,r.pdat) FROM operw WHERE tag = 'CRDVD' AND REF = r.REF) crdvd,
          (SELECT NAME  FROM op_sos WHERE sos = r.sos) sos,
          (SELECT VALUE FROM OPERW WHERE tag = 'CRDND' AND REF = r.REF) crdnd,
          r.REF ref_now, nlsa, nam_a, nlsb, nam_b
     FROM oper r, cc_deal d, nd_ref nr
    WHERE r.REF = nr.REF AND nr.nd = d.nd
 ;

PROMPT *** Create  grants  CC_KOL_ALL ***
grant SELECT                                                                 on CC_KOL_ALL      to BARSREADER_ROLE;
grant SELECT                                                                 on CC_KOL_ALL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_KOL_ALL      to RCC_DEAL;
grant SELECT                                                                 on CC_KOL_ALL      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_KOL_ALL.sql =========*** End *** ===
PROMPT ===================================================================================== 
