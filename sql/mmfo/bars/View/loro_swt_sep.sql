

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/LORO_SWT_SEP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view LORO_SWT_SEP ***

  CREATE OR REPLACE FORCE VIEW BARS.LORO_SWT_SEP ("SWREF", "MT", "SENDER", "NLSA", "DATE_IN", "S", "VDATE", "NAM_A", "ACCD", "K50", "K70", "K72", "K57", "K58", "K59", "OTM", "KOD_N", "KOD_G", "KOD_B", "RNK", "P40", "MFOB", "NLSB", "ID_B", "NAM_B", "NAZN", "N") AS 
  SELECT x.SWREF,
          x.MT,
          x.SENDER,
          x.nls NLSA,
          x.date_in,
          x.S,
          x.vdate,
          x.NAM_A,
          x.accd,
          x.k50,
          x.k70,
          x.k72,
          x.k57,
          x.k58,
          x.k59,
          0 otm,
          '1222' KOD_N,
          c.country KOD_G,
          b.kod_B,
          c.RNK,
          '  ' p40,
          TRIM (SUBSTR (x.txt, 01, 06)) MFOB,
          TRIM (SUBSTR (x.txt, 07, 14)) NLSB,
          TRIM (SUBSTR (x.txt, 21, 10)) ID_B,
          TRIM (SUBSTR (x.txt, 31, 38)) NAM_B,
          TRIM (SUBSTR (x.txt, 69, 160)) NAZN,
          NULL n
     FROM (SELECT j.SWREF,
                  j.MT,
                  j.SENDER,
                  a.nls,
                  loro.F_NLSB (j.SWREF) TXT,
                  j.date_in,
                  j.AMOUNT / 100 S,
                  j.vdate,
                  a.nms NAM_A,
                  j.accd,
                  a.rnk,
                  SUBSTR (
                        (SELECT REPLACE (VALUE, CHR (13) || CHR (10), '~')
                           FROM SW_OPERW
                          WHERE SWREF = j.swref AND TAG = '50')
                     || '~',
                     1,
                     160)
                     k50,
                  SUBSTR (
                        (SELECT REPLACE (VALUE, CHR (13) || CHR (10), '~')
                           FROM SW_OPERW
                          WHERE SWREF = j.swref AND TAG = '57')
                     || '~',
                     1,
                     160)
                     k57,
                  SUBSTR (
                        (SELECT REPLACE (VALUE, CHR (13) || CHR (10), '~')
                           FROM SW_OPERW
                          WHERE SWREF = j.swref AND TAG = '58')
                     || '~',
                     1,
                     160)
                     k58,
                  SUBSTR (
                        (SELECT REPLACE (VALUE, CHR (13) || CHR (10), '~')
                           FROM SW_OPERW
                          WHERE SWREF = j.swref AND TAG = '59')
                     || '~',
                     1,
                     160)
                     k59,
                  SUBSTR (
                        (SELECT REPLACE (VALUE, CHR (13) || CHR (10), '~')
                           FROM SW_OPERW
                          WHERE SWREF = j.swref AND TAG = '70')
                     || '~',
                     1,
                     160)
                     k70,
                  SUBSTR (
                        (SELECT REPLACE (VALUE, CHR (13) || CHR (10), '~')
                           FROM SW_OPERW
                          WHERE SWREF = j.swref AND TAG = '72')
                     || '~',
                     1,
                     160)
                     k72
             FROM sw_journal j, accounts a
            WHERE     j.io_ind = 'O'
                  AND j.mt < 300
                  AND j.CURRENCY = 'UAH'
                  AND j.date_pay IS NULL
                  AND j.accd = a.acc
                  AND a.kv = 980
                  AND a.nbs = '1600') x,
          customer c,
          custbank b
    WHERE x.rnk = c.rnk AND c.rnk = b.rnk;

PROMPT *** Create  grants  LORO_SWT_SEP ***
grant SELECT                                                                 on LORO_SWT_SEP    to BARSREADER_ROLE;
grant SELECT                                                                 on LORO_SWT_SEP    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LORO_SWT_SEP    to START1;
grant SELECT                                                                 on LORO_SWT_SEP    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/LORO_SWT_SEP.sql =========*** End *** =
PROMPT ===================================================================================== 
