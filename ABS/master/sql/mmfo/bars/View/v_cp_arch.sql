

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_ARCH.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_ARCH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_ARCH ("REF_REPO", "REF", "ID", "CP_ID", "KV", "NAME", "DAT_UG", "DAT_OPL", "TIP", "IR", "DAT_ROZ", "SUMB", "T", "TQ", "N", "D", "P", "R", "S", "Z", "VD", "VP", "STR_REF", "OP", "SOS", "SN", "REF_MAIN", "NOM", "ND", "NBS", "NBB", "NTIK", "RNK_EMI") AS 
  SELECT a.REF_REPO,
          a.REF,
          a.ID,
          k.CP_ID,
          k.KV,
          k.NAME,
          a.DAT_UG,
          a.DAT_OPL,
          k.TIP,
          k.IR,
          a.DAT_ROZ,
          a.SUMB,
          a.T,
          a.TQ,
          a.N,
          a.D,
          a.P,
          a.R,
          a.S,
          a.Z,
          a.VD,
          a.VP,
          a.STR_REF,
          a.OP,
          o.SOS,
          a.SN,
          a.REF_MAIN,
          a.NOM,
          o.nd,
          SUBSTR (o.nlsa, 1, 4) nbs,
          ct.nbb,
          ct.ntik,
          k.RNK_EMI
     FROM CP_ARCH a,
          oper o,
          (SELECT id,
                  CP_ID,
                  TIP,
                  IR,
                  KV,
                  NAME,
                  RNK AS RNK_EMI
             FROM cp_kod
            WHERE id > 0) k,
          cp_ticket ct
    WHERE     k.id = a.ID
          AND a.REF = o.REF
          AND NVL (o.sos, 3) > 0
          AND ct.REF(+) = a.REF;

PROMPT *** Create  grants  V_CP_ARCH ***
grant SELECT                                                                 on V_CP_ARCH       to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_ARCH       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_ARCH       to CP_ROLE;
grant SELECT                                                                 on V_CP_ARCH       to START1;
grant SELECT                                                                 on V_CP_ARCH       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_ARCH.sql =========*** End *** ====
PROMPT ===================================================================================== 
