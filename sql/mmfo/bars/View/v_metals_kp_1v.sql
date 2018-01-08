

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_METALS_KP_1V.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_METALS_KP_1V ***

  CREATE OR REPLACE FORCE VIEW BARS.V_METALS_KP_1V ("BRANCH", "KOD", "KV", "VES", "VES_UN", "TYPE_", "PROBA", "NAME", "NAME_COMMENT", "CENA", "CENA_K", "CENA_NOMI", "NLS_3800", "KUPIVLYA", "PRODAZA", "PDV") AS 
  SELECT SYS_CONTEXT ('bars_context', 'user_branch') branch,
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
          NULL,
          CASE
             WHEN NVL (cena_k, 0) > 0
             THEN
                make_docinput_url (
                   DECODE (NVL (m.cena_nomi, 0), 0, 'TM7', 'TI7'),
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
                         4),
                      'FM999999999999999999999990.0000',
                      'NLS_NUMERIC_CHARACTERS = ''. '''),
                   'Kv_A',
                   m.kv,
                   'Nls_A',
                   a.nls,
                   'reqv_BM__Y',
                   m.cena_nomi / 100,
                   'APROC',
                   'Begin null; end;@ begin  web_tt_bm(2); end;')
             ELSE
                NULL
          END
             kupivlya,
          CASE
             WHEN NVL (cena, 0) > 0  and GetGlobalOption('BM_PROD')=1
             THEN
                make_docinput_url (
                   DECODE (NVL (m.cena_nomi, 0), 0, 'TM8', 'TI8'),
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
                         4),
                      'FM999999999999999999999990.0000',
                      'NLS_NUMERIC_CHARACTERS = ''. '''),
                   'Kv_A',
                   m.kv,
                   'Nls_A',
                   a.nls,
                   'reqv_BM__Y',
                   m.cena_nomi / 100,
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
                  cena_bm (2, kod) cena_k
             FROM bank_metals) M,
          accounts a
    WHERE     a.kv = m.kv
          AND a.dazs IS NULL
          AND a.nls =
                 nbs_ob22_null (
                    SUBSTR (tobopack.gettoboparam ('CASH11'), 1, 4),
                    '0' || m.type_)
          AND (m.cena > 0 OR m.cena_k > 0);

PROMPT *** Create  grants  V_METALS_KP_1V ***
grant SELECT                                                                 on V_METALS_KP_1V  to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_METALS_KP_1V  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_METALS_KP_1V  to PYOD001;
grant SELECT                                                                 on V_METALS_KP_1V  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_METALS_KP_1V  to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_METALS_KP_1V  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_METALS_KP_1V.sql =========*** End ***
PROMPT ===================================================================================== 
