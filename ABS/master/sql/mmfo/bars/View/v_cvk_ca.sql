

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CVK_CA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CVK_CA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CVK_CA ("MFO", "NB", "NLS", "DAOS", "VID", "TVO", "NAME_BLOK", "FIO_BLOK", "FIO_ISP", "INF_ISP", "ADDR", "OKPO", "INF_ISP2") AS 
  WITH ps264
        AS (SELECT nbs
              FROM ps
             WHERE nbs LIKE '264_' AND LENGTH (LTRIM (RTRIM (nbs))) = 4)
   SELECT SUBSTR (f_ourmfo, 1, 9) mfo,
          (SELECT SUBSTR (val, 1, 38)
             FROM branch_parameters
            WHERE tag = 'NAME_BRANCH' AND branch = s.branch)
             nb,
          s.nls,
          s.daos,
          DECODE (s.vid,  13, '1',  14, '2',  '3') vid,
          (SELECT NVL (MIN (SUBSTR (VALUE, 1, 3)), 0)
             FROM accountsw
            WHERE acc = s.acc AND tag = 'CVK_TVO')
             tvo,
          (SELECT MIN (SUBSTR (VALUE, 1, 38))
             FROM accountsw
            WHERE acc = s.acc AND tag = 'CVK_BLOK')
             name_blok,
          (SELECT MIN (SUBSTR (VALUE, 1, 76))
             FROM accountsw
            WHERE acc = s.acc AND tag = 'CVK_FIOR')
             fio_blok,
          (SELECT SUBSTR (t.fio, 1, 38)
             FROM staff t
            WHERE t.id = s.isp)
             AS fio_isp,
          (SELECT MIN (SUBSTR (VALUE, 1, 38))
             FROM accountsw
            WHERE acc = s.acc AND tag = 'CVK_INF')
             inf_isp,
          (SELECT SUBSTR (val, 1, 38)
             FROM branch_parameters
            WHERE tag = 'ADR_BRANCH' AND branch = s.branch)
             addr,
          c.okpo,
          (SELECT MIN (SUBSTR (VALUE, 1, 38))
             FROM accountsw
            WHERE acc = s.acc AND tag = 'CVK_INF2')
             inf_isp2
     FROM accounts s, ps264, customer c
    WHERE s.nbs = ps264.nbs AND s.dazs IS NULL AND s.rnk = c.rnk;

comment on column BARS.V_CVK_CA.inf_isp2 is 'Інформація про працівника банку, відповідального за ведення рахунка виборчого фонду кандидата (номер телефону, адреса електронної пошти)';

PROMPT *** Create  grants  V_CVK_CA ***
grant SELECT                                                                 on V_CVK_CA        to BARSREADER_ROLE;
grant SELECT                                                                 on V_CVK_CA        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CVK_CA        to RPBN002;
grant SELECT                                                                 on V_CVK_CA        to START1;
grant SELECT                                                                 on V_CVK_CA        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CVK_CA.sql =========*** End *** =====
PROMPT ===================================================================================== 
