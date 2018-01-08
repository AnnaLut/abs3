

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOCS_TOBO.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOCS_TOBO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOCS_TOBO ("REF", "TT", "USERID", "ND", "NLSA", "S", "S_", "LCV", "KV", "VDAT", "PDAT", "S2", "S2_", "LCV2", "KV2", "MFOB", "NLSB", "DK", "SK", "DATD", "NAZN", "TOBO", "SOS", "DEAL_TAG", "PRTY", "NAM_B", "MFOA", "DATP", "VOB") AS 
  SELECT UNIQUE (op.REF),
                 op.tt,
                 op.userid,
                 op.nd,
                 op.nlsa,
                 op.s,
                 op.s / POWER (10, t1.dig),
                 t1.lcv,
                 op.kv,
                 op.vdat,
                 op.pdat,
                 op.s2,
                 op.s2 / POWER (10, t2.dig),
                 t2.lcv,
                 op.kv2,
                 op.mfob,
                 op.nlsb,
                 op.dk,
                 op.sk,
                 op.datd,
                 op.nazn,
                 op.tobo,
                 op.sos,
                 op.deal_tag,
                 op.prty,
                 op.nam_b,
                 op.mfoa,
                 op.datp,
                 op.vob
     FROM oper op
     join tabval t1
       on ( t1.kv = op.kv )
     join tabval t2
       on ( t2.kv = op.kv2 )
     join ( select unique t.ref 
              from opldok   t
              join accounts a
                on ( t.acc = a.acc )
             where a.branch LIKE SYS_CONTEXT ('bars_context','user_branch_mask') 
          ) r
       on ( r.REF = op.REF )
    WHERE op.sos >= 0
    UNION ALL
   /* документы сторнированые по счетам даного отделения*/
   SELECT op.REF,
          op.tt,
          op.userid,
          op.nd,
          op.nlsa,
          op.s,
          op.s / POWER (10, t1.dig),
          t1.lcv,
          op.kv,
          op.vdat,
          op.pdat,
          op.s2,
          op.s2 / POWER (10, t2.dig),
          t2.lcv,
          op.kv2,
          op.mfob,
          op.nlsb,
          op.dk,
          op.sk,
          op.datd,
          op.nazn,
          op.tobo,
          op.sos,
          op.deal_tag,
          op.prty,
          op.nam_b,
          op.mfoa,
          op.datp,
          op.vob
     FROM oper op, tabval t1, tabval t2
    WHERE     t1.kv = op.kv
          AND t2.kv = op.kv2
          AND sos < 0
          AND op.branch = SYS_CONTEXT ('bars_context', 'user_branch');

PROMPT *** Create  grants  V_DOCS_TOBO ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DOCS_TOBO     to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DOCS_TOBO     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOCS_TOBO.sql =========*** End *** ==
PROMPT ===================================================================================== 
