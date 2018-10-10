

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_IICFILES_FORM_STO.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_IICFILES_FORM_STO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_IICFILES_FORM_STO ("REF", "DK", "TT", "MSGCODE", "ACC", "NLS", "KV", "OKPO", "S", "VDAT", "NAZN") AS 
  SELECT UNIQUE
          p.REF,
          p.dk,
          p.tt,
          CASE
             WHEN p.tt = p.tt_asg THEN OW_FILES_PROC.get_w4_msgcode(p.nlsb, p.kv)
             ELSE NVL (m.msgcode, p.w4_msgcode)
          END
             w4_msgcode,
          a.acc,
          a.nls,
          a.kv,
          c.okpo,
          p.s / 100 s,
          p.vdat,
          p.nazn
     FROM table(OW_FILES_PROC.w4_form_sto) p,
          accounts a,
          customer c,
          ow_iic_msgcode m
    WHERE     p.acc = a.acc
          AND a.rnk = c.rnk
          AND p.tt = m.tt(+)
          AND p.mfoa = m.mfoa(+)
          AND p.nlsa LIKE m.nlsa(+);

PROMPT *** Create  grants  V_OW_IICFILES_FORM_STO ***
grant SELECT                                                                 on V_OW_IICFILES_FORM_STO to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_IICFILES_FORM_STO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_IICFILES_FORM_STO to OW;
grant SELECT                                                                 on V_OW_IICFILES_FORM_STO to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_IICFILES_FORM_STO.sql =========***
PROMPT ===================================================================================== 
