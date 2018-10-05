

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
          'Äðóê' PRINT
     FROM oper o
    WHERE o.tt in (
                   'AA0', 'AA3', 'AA4', 'AA5', 'AA6', 'AA7', 'AA8', 'AA9', '107', 
                   '112', '113', '115', '116', '130', '132', '136', '140', '142', 
                   '146', '19C', '19K', '401', '402', '403', '404', '406', '416', 
                   '417', 'C05', 'HO1', 'HO3', 'HO6', 'HO9', 'PKK', 'ÑN1', 'MUK', 
                   'MUM', 'MUV', '027', '02À', '02B', '02C', '03B', '077', '07A', 
                   'ÒÌÊ', 'ÒÌÐ', 'ÒÌ1', 'ÒÌ2', 'ÒÌ7', 'ÒÌ8', 'Ò²Ê', 'Ò²Ð', 'Ò11', 
                   'Ò12', 'Ò17', 'Ò18', 'ÒÊÊ', 'ÒÒ²', 'ÂÌY', 'BNY'
                   )
              and (case
                   when kv2=980  then s2
                   when kv2!=980 then gl.p_icurval(kv2,s2, o.vdat/*gl.bd*/)
                   else 0
                   end) >= 15000000
;

comment on table BARS.V_OPER_FM is 'Îïåð. áåç â³äêðèòòÿ ðàõ. ÔÌ';

PROMPT *** Create  grants  V_OPER_FM ***
grant SELECT                                                                 on V_OPER_FM       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPER_FM       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPER_FM.sql =========*** End *** ====
PROMPT ===================================================================================== 
