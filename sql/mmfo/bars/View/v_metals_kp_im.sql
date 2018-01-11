

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_METALS_KP_IM.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_METALS_KP_IM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_METALS_KP_IM ("BRANCH", "KOD", "KV", "VES", "VES_UN", "TYPE_", "PROBA", "NAME", "NAME_COMMENT", "CENA", "CENA_K", "CENA_NOMI", "SUM_KOM", "OB_22", "NLS_3800", "KUPIVLYA", "PRODAZA", "PDV") AS 
  SELECT SYS_CONTEXT ('bars_context', 'user_branch'),
          m.kod,
          m.kv,
          m.ves,
          m.ves_un,
          m.type_,
          m.proba,
          SUBSTR (m.NAME, 1, 60),
          SUBSTR (m.name_comment, 1, 60),
          m.cena,
          m.cena_k,
          m.cena_nomi,
          m.sum_kom,
          m.ob_22,
          NULL,
          CASE
             WHEN NVL (cena_k, 0) > 0
             THEN
                make_docinput_url (
                   DECODE (NVL (m.cena_nomi, 0), 0, 'TMK', 'TTK'),
                   'Купити',
                   'DisR',
                   '1',
                   'reqv_BM__C',
                   m.kod,
                   'reqv_BM__N',
                   m.name_comment,
                   'reqv_BM__R',
                   TO_CHAR (m.cena_k / 100,
                            'FM999999999999999999999990.00',
                            'NLS_NUMERIC_CHARACTERS = ''. '''),
                   'reqv_BM__U',
                   TO_CHAR (ROUND (NVL (ves_un, ves / 31.1034807), 2),
                            'FM999999999999999999999990.0000',
                            'NLS_NUMERIC_CHARACTERS = ''. '''),
                   'reqv_MKURS',
                   TO_CHAR (
                      ROUND (
                           m.cena_k
                         / (100 * ROUND (NVL (ves_un, ves / 31.1034807), 2)),
                         2),
                      'FM999999999999999999999990.0000',
                      'NLS_NUMERIC_CHARACTERS = ''. '''),
                   'Kv_A',
                   m.kv,
                   'reqv_BM_22',
                   m.ob_22,
                   'Nls_A',
                   a.nls,
                   'reqv_BM__Y',
                   m.cena_nomi / 100)
             ELSE
                NULL
          END
             kupivlya,
          CASE
             WHEN NVL (cena, 0) > 0
             THEN
                make_docinput_url (
                   DECODE (NVL (m.cena_nomi, 0), 0, 'TMU', 'TTI'),
                   'Продати',
                   'DisR',
                   '1',
                   'reqv_BM__C',
                   m.kod,
                   'reqv_BM__N',
                   m.name_comment,
                   'reqv_BM__R',
                   TO_CHAR (m.cena / 100,
                            'FM999999999999999999999990.00',
                            'NLS_NUMERIC_CHARACTERS = ''. '''),
                   'reqv_BM__U',
                   TO_CHAR (ROUND (NVL (ves_un, ves / 31.1034807), 2),
                            'FM999999999999999999999990.0000',
                            'NLS_NUMERIC_CHARACTERS = ''. '''),
                   'reqv_MKURS',
                   TO_CHAR (
                      ROUND (
                           m.cena
                         / (100 * ROUND (NVL (ves_un, ves / 31.1034807), 2)),
                         2),
                      'FM999999999999999999999990.0000',
                      'NLS_NUMERIC_CHARACTERS = ''. '''),
                   'Kv_A',
                   m.kv,
                   'reqv_BM_22',
                   m.ob_22,
                   'Nls_A',
                   a.nls,
                   'reqv_BM__Y',
                   m.cena_nomi / 100,
                   'reqv_BM__Z',
                   m.sum_kom / 100,
                   'reqv_PDV',
                   TO_CHAR (NVL (m.pdv, 0)),
                   'APROC',
                   'Begin null; end;@ begin  web_tt_bm(1); end;')
             ELSE
                NULL
          END
             prodaza,
          m.pdv
     FROM (SELECT kod,
                  kv,
                  ves,
                  ves_un,
                  type_,
                  proba,
                  NAME,
                  name_comment,
                  DECODE (type_, 2, 1, 0) pdv,
                  cena_nomi,
                  cena_bm (1, kod) cena,
                  cena_bm (2, kod) cena_k,
                  sum_kom,
                  ob_22
             FROM bank_metals) M,
          ACCOUNTS A
    ---   WHERE  (m.cena > 0 OR m.cena_k > 0)
    ---           and NVL(m.sum_kom,0)<>0
    ---           and m.ob_22 is not NULL
    ---           and m.ob_22 = a.ob22
    ---           and m.type_=4
    WHERE     (m.cena > 0 OR m.cena_k > 0)
          AND NVL (m.sum_kom, 0) <> 0
          AND m.ob_22 IS NOT NULL
          AND m.ob_22 = a.ob22
          AND a.nls = nbs_ob22_null (SUBSTR (9819, 1, 4), m.ob_22)
          AND m.type_ = 4;

PROMPT *** Create  grants  V_METALS_KP_IM ***
grant SELECT                                                                 on V_METALS_KP_IM  to BARSREADER_ROLE;
grant SELECT                                                                 on V_METALS_KP_IM  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_METALS_KP_IM  to PYOD001;
grant SELECT                                                                 on V_METALS_KP_IM  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_METALS_KP_IM.sql =========*** End ***
PROMPT ===================================================================================== 
