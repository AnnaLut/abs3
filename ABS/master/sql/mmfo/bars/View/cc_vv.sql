

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_VV.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_VV ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_VV ("CC_ID", "ND", "DAT1", "NMK", "KV", "NLSD", "MFOK", "NLSK", "S", "SDI", "NLS_SDI", "WIDA", "DISKO", "WIDA_PL") AS 
  SELECT cc_id,
          nd,
          dat1,
          nmk,
          kv,
          nlsd,
          mfok,
          nlsk,
          s,
          sdi,
          nls_sdi,
          make_docinput_url (
             tt,
             TO_CHAR (s,
                      '999999999999999D99MI',
                      'NLS_NUMERIC_CHARACTERS = '',.'''),
             'Nd',
             SUBSTR (cc_id, 1, 10),
             'Kv_A',
             TO_CHAR (kv),
             'Nls_A',
             nlsd,
             (CASE
                 WHEN tt IN ('KK2') OR vidd IN (2, 3) THEN NULL
                 ELSE 'Mfo_B'
              END),
             (CASE
                 WHEN tt IN ('KK2') OR vidd IN (2, 3) THEN NULL
                 ELSE mfok
              END),
             'Kv_B',
             TO_CHAR (kv),
             'Nls_B',
             (CASE
                 WHEN tt IN ('KK2') OR vidd IN (2, 3) THEN NULL
                 ELSE nlsk
              END),
             --  'Id_B',
             --DECODE (mfok, getglobaloption ('MFO'), '', okpo),
             --'Nam_B',
             --DECODE (mfok, getglobaloption ('MFO'), '', nmk),
             (CASE
                 WHEN vidd IN (2,
                               3,
                               12,
                               13)
                 THEN
                    NULL
                 ELSE
                    'SumC'
              END),
             (CASE
                 WHEN vidd IN (2,
                               3,
                               12,
                               13)
                 THEN
                    NULL
                 ELSE
                    TO_CHAR (s)
              END),
             'Nazn',
                DECODE (SUBSTR (nlsk, 1, 3),
                        '100', 'Видача коштiв готiвкою',
                        'Перерахування коштiв')
             || ' згiдно кредитного договору № '
             || cc_id
             || ' вiд '
             || TO_CHAR (dat1, 'dd.mm.yyyy'),
             (CASE
                 WHEN SUBSTR (nlsk, 1, 3) = '100' THEN 'reqv_FIO'
                 ELSE NULL
              END),
             (CASE WHEN SUBSTR (nlsk, 1, 3) = '100' THEN nmk ELSE NULL END),
             (CASE
                 WHEN SUBSTR (nlsk, 1, 3) = '100' THEN 'reqv_PASP'
                 ELSE NULL
              END),
             (CASE
                 WHEN SUBSTR (nlsk, 1, 3) = '100'
                 THEN
                    (SELECT k.NAME
                       FROM passp k, person p
                      WHERE p.rnk = rnkg AND NVL (p.passp, 1) = k.passp(+))
                 ELSE
                    NULL
              END),
             (CASE
                 WHEN SUBSTR (nlsk, 1, 3) = '100' THEN 'reqv_PASPN'
                 ELSE NULL
              END),
             (CASE
                 WHEN SUBSTR (nlsk, 1, 3) = '100'
                 THEN
                    (SELECT p.ser || ' ' || p.numdoc
                       FROM person p
                      WHERE p.rnk = rnkg AND NVL (p.passp, 1) = 1)
                 ELSE
                    NULL
              END),
             (CASE
                 WHEN     tt IN ('KK2')
                      AND vidd IN (11, 12, 13)
                      AND okpo = '0000000000'
                 THEN
                    'reqv_Ф'
                 ELSE
                    NULL
              END),
             (CASE
                 WHEN     tt IN ('KK2')
                      AND vidd IN (11, 12, 13)
                      AND okpo = '0000000000'
                 THEN
                    (SELECT p.ser || ' ' || p.numdoc
                       FROM person p
                      WHERE p.rnk = rnkg AND NVL (p.passp, 1) = 1)
                 ELSE
                    NULL
              END),
             (CASE
                 WHEN SUBSTR (nlsk, 1, 3) = '100' THEN 'reqv_ATRT'
                 ELSE NULL
              END),
             (CASE
                 WHEN SUBSTR (nlsk, 1, 3) = '100'
                 THEN
                    (SELECT p.organ || ' ' || TO_CHAR (P.PDATE, 'dd/mm/yyyy')
                       FROM person p
                      WHERE p.rnk = rnkg)
                 ELSE
                    NULL
              END),
             (CASE
                 WHEN SUBSTR (nlsk, 1, 3) = '100' THEN 'reqv_ADRES'
                 ELSE NULL
              END),
             (CASE
                 WHEN SUBSTR (nlsk, 1, 3) = '100'
                 THEN
                    (SELECT adr
                       FROM customer
                      WHERE rnk = rnkg)
                 ELSE
                    NULL
              END),
             (CASE
                 WHEN SUBSTR (nlsk, 1, 3) = '100' THEN 'reqv_DT_R'
                 ELSE NULL
              END),
             (CASE
                 WHEN SUBSTR (nlsk, 1, 3) = '100'
                 THEN
                    (SELECT TO_CHAR (bday, 'dd.mm.yyyy')
                       FROM person
                      WHERE rnk = rnkg)
                 ELSE
                    NULL
              END))
             wida,
          DECODE (
             NVL (sdi, 0),
             0, '',
             DECODE (
                LENGTH (nls_sdi),
                0, '',
                make_docinput_url (
                   DECODE (kv, 980, '008', '016'),
                   TO_CHAR (sdi,
                            '999999999999999D99MI',
                            'NLS_NUMERIC_CHARACTERS = '',.'''),
                   'Kv_A',
                   TO_CHAR (kv),
                   'Sk',
                   '14',
                   'Nls_A',
                   nls_sdi,
                   'SumC',
                   TO_CHAR (sdi),
                   'Nazn',
                      'Внесення поч.комiciї згiдно '
                   || 'кредитного договору № '
                   || cc_id
                   || ' вiд '
                   || TO_CHAR (dat1, 'dd.mm.yyyy'))))
             disko,
          make_url (
             '/barsroot/barsweb/dynform.aspx?form=frm_pl_ins',
             'По пл.інстр.',null,null,'nd',nd)
             WIDA_PL
     --FunNSIEditF("CCK_PL_INS1[NSIFUNCTION][PROC=>PUL.Set_Mas_Ini('ND',:ND,'Реф КД')][EXEC=>BEFORE]",2)
     --If SqlPLSQLCommand( hSql(), "PUL.Set_Mas_Ini( 'ND', Str(N_NDp) , '?ao EA' )" ) Call FunNSIEditF("CCK_PL_INS1[NSIFUNCTION]",2)
     FROM (SELECT d.cc_id,
                  d.vidd,
                  d.nd,
                  d.sdate dat1,
                  c.nmk,
                  a.kv,
                  a.nls nlsd,
                  d.rnk rnkg,
                  c.okpo,
                  NVL (ad.mfokred, getglobaloption ('MFO')) mfok,
                  (CASE
                      WHEN NVL (ad.mfokred, getglobaloption ('MFO')) !=
                              getglobaloption ('MFO')
                      THEN
                         'KK2'
                      WHEN     (   ad.acckred IS NULL
                                OR SUBSTR (ad.acckred, 1, 3) = '100')
                           AND d.vidd IN (11, 12, 13)
                      THEN
                         'KK3'
                      ELSE
                         'KK1'
                   END)
                     tt,
                  NVL (ad.acckred, branch_usr.get_branch_param2 ('CASH', 0))
                     nlsk,
                  (CASE
                      WHEN a8.ostx - a8.ostc < 0
                      THEN
                         ABS (a8.ostx - a8.ostc) / 100
                      ELSE
                         0
                   END)
                     s,
                  NVL (
                     (SELECT 0
                        FROM accounts aa, nd_acc nn
                       WHERE     nn.nd = d.nd
                             AND aa.acc = nn.acc
                             AND aa.tip = 'SDI'
                             AND aa.kv = ad.kv
                             AND aa.ostb != 0
                             AND aa.dazs IS NULL
                             AND ROWNUM = 1),
                     cck_app.to_number2 (cck_app.get_nd_txt (d.ND, 'S_SDI')))
                     sdi,
                  (SELECT aa.nls
                     FROM accounts aa, nd_acc nn
                    WHERE     nn.nd = d.nd
                          AND aa.acc = nn.acc
                          AND aa.tip = 'SDI'
                          AND aa.kv = ad.kv
                          AND aa.ostb = 0
                          AND aa.dazs IS NULL
                          AND ROWNUM = 1)
                     nls_sdi
             FROM cc_deal d,
                  accounts a,
                  cc_add ad,
                  nd_acc n,
                  customer c,
                  accounts a8,
                  nd_acc n8
            WHERE     d.branch = SYS_CONTEXT ('bars_context', 'user_branch')
                  AND d.nd = n.nd
                  AND d.rnk = c.rnk
                  AND n.acc = a.acc
                  AND a.tip = 'SS '
                  AND a8.acc = n8.acc
                  AND n8.nd = d.nd
                  AND a8.tip = 'LIM'
                  AND (   a.dapp IS NULL
                       OR (    d.vidd IN (12,
                                          13,
                                          2,
                                          3)
                           AND EXISTS
                                  (SELECT 1
                                     FROM nd_acc nn, accounts a9
                                    WHERE     nn.nd = d.nd
                                          AND a9.acc = nn.acc
                                          AND a9.ostc != 0
                                          AND a9.tip = 'CR9')))
                  AND a.daos =
                         (SELECT MAX (a0.daos)
                            FROM nd_acc n0, accounts a0
                           WHERE     n0.nd = d.nd
                                 AND a0.acc = n0.acc
                                 AND a0.dazs IS NULL
                                 AND a0.tip = 'SS ')
                  AND ad.wdate <= gl.bd
                  AND d.sos = 10
                  AND d.nd = ad.nd
                  AND ad.adds = 0);

PROMPT *** Create  grants  CC_VV ***
grant SELECT                                                                 on CC_VV           to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on CC_VV           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_VV           to RCC_DEAL;
grant SELECT                                                                 on CC_VV           to UPLD;
grant FLASHBACK,SELECT                                                       on CC_VV           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_VV.sql =========*** End *** ========
PROMPT ===================================================================================== 
