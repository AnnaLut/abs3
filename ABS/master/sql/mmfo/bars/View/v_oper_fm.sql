

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPER_FM.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPER_FM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPER_FM ("REF", "ND", "PDAT", "DK", "MFOA", "NLSA", "KV", "NAM_A", "MFOB", "NLSB", "KV2", "NAM_B", "NAZN", "BRANCH", "USERID", "TT", "ID_A", "ID_B", "S", "S2", "PRINT") AS 
  SELECT o.REF,
          o.nd,
          o.pdat,
          o.dk,
          o.mfoa,
          o.nlsa,
          o.kv,
          o.nam_a,
          o.mfob,
          o.nlsb,
          o.kv2,
          o.nam_b,
          o.nazn,
          o.branch,
          o.userid,
          o.tt,
          o.id_a,
          o.id_b,
          o.s / 100 s,
          o.s2 / 100 s2,
          'Друк' PRINT
     FROM oper o,
          (SELECT DISTINCT REF
             FROM operw
            WHERE tag IN ('BPLAC',
                          'WORK',
                          'PHONW',
                          'O_REP',
                          'RIZIK',
                          'PUBLP',
                          'FSVSN',
                          'DJER')) ow
    WHERE     o.REF = ow.REF
                  and (case
                   when kv2=980  then s2
                   when kv2!=980 then gl.p_icurval(kv2,s2, o.vdat/*gl.bd*/)
                   else 0
                   end) >= 15000000
;

PROMPT *** Create  grants  V_OPER_FM ***
grant SELECT                                                                 on V_OPER_FM       to BARSREADER_ROLE;
grant SELECT                                                                 on V_OPER_FM       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPER_FM       to START1;
grant SELECT                                                                 on V_OPER_FM       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPER_FM.sql =========*** End *** ====
PROMPT ===================================================================================== 
