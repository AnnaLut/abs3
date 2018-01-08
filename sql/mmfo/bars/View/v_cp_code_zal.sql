

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_CODE_ZAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_CODE_ZAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_CODE_ZAL ("ID", "ISIN", "CP_NAME", "BASEY", "BNAME", "KY", "DOK", "DNK", "TIP", "TIP_NAME", "DCP", "EMI", "EMINAME", "DAT_EM", "DOX", "DOCNAME", "CENA", "KV", "DATP", "IR", "RNK", "NMK", "COUNTRY", "AMORT", "VR_NAME", "PR_AKT", "IN_BR", "K23", "CENA_KUP", "KAT23", "PR1_KUP", "PERIOD_KUP", "PR_AMR", "QUOT_SIGN", "CENA_START", "METR", "PAWN", "PAWNNAME", "ZAL_CP", "HIERARCHY_ID", "HIERNAME", "EXPIRY", "VNCRP", "VNCRR", "IDT", "TYPENAME") AS 
  SELECT CP_KOD.ID as ID,
         CP_KOD.CP_ID ISIN,
         CP_KOD.NAME CP_NAME,
         CP_KOD.BASEY,
         BASEY.NAME BNAME,
         CP_KOD.KY,
         CP_KOD.DOK,
         CP_KOD.DNK,
         CP_KOD.TIP,
         CC_TIPD.NAME TIP_NAME,
         CP_KOD.DCP,
         CP_KOD.EMI,
         CP_EMI.NAME EMINAME,
         CP_KOD.DAT_EM,
         CP_KOD.DOX,
         CP_DOX.NAME DOCNAME,
         CP_KOD.CENA,
         CP_KOD.KV,
         CP_KOD.DATP,
         CP_KOD.IR,
         CP_KOD.RNK,
         CUSTOMER.NMK,
         CP_KOD.COUNTRY,
         CP_KOD.AMORT,
         CP_VR.NAME VR_NAME,
         CP_KOD.PR_AKT,
         CP_KOD.IN_BR,
         CP_KOD.K23,
         CP_KOD.CENA_KUP,
         CP_KOD.KAT23,
         CP_KOD.PR1_KUP,
         CP_KOD.PERIOD_KUP,
         CP_KOD.PR_AMR,
         CP_KOD.QUOT_SIGN,
         CP_KOD.CENA_START,
         CP_KOD.METR,
         CP_KOD.PAWN,
         CC_PAWN.NAME PAWNNAME,
         CP_KOD.ZAL_CP,
         CP_KOD.HIERARCHY_ID,
         CP_HIERARCHY.NAME HIERNAME,
         CP_KOD.EXPIRY,
         CP_KOD.VNCRP,
         CP_KOD.VNCRR,
         CP_KOD.IDT,
         CP_TYPE.NAME TYPENAME
    FROM CP_KOD,
         BASEY,
         CC_TIPD,
         CP_EMI,
         CP_DOX,
         CUSTOMER,
         CP_VR,
         CC_PAWN,
         CP_HIERARCHY,
         CP_TYPE
   WHERE     BASEY.BASEY(+) = CP_KOD.BASEY
         AND CC_TIPD.TIPD(+) = CP_KOD.TIP
         AND CP_EMI.EMI(+) = CP_KOD.EMI
         AND CP_DOX.DOX(+) = CP_KOD.DOX
         AND CUSTOMER.RNK(+) = CP_KOD.RNK
         AND CP_VR.VR(+) = CP_KOD.AMORT
         AND CC_PAWN.PAWN(+) = CP_KOD.PAWN
         AND CP_HIERARCHY.ID(+) = CP_KOD.HIERARCHY_ID
         AND CP_TYPE.IDT(+) = CP_KOD.IDT
         AND tip = 2
ORDER BY CP_KOD.ID ASC;

PROMPT *** Create  grants  V_CP_CODE_ZAL ***
grant SELECT                                                                 on V_CP_CODE_ZAL   to BARSREADER_ROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_CP_CODE_ZAL   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_CODE_ZAL   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_CODE_ZAL.sql =========*** End *** 
PROMPT ===================================================================================== 
