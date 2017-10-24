

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CASH_BRANCH_LIMIT_PG.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CASH_BRANCH_LIMIT_PG ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CASH_BRANCH_LIMIT_PG ("DATM", "DATX", "DAT_LIM", "DNI", "BRANCH", "KV", "ISH", "ISR", "L_T", "LIM_P", "LIM_M", "PERELIM_P", "PERELIM_M") AS 
  SELECT datm, datx, dat_lim, dni, branch, kv, ish, isr, l_t, lim_p, lim_m,
          GREATEST (isr - lim_p, 0) perelim_p,
          GREATEST (isr - lim_m, 0) perelim_m
     FROM (SELECT l.branch, l.kv, l.l_t, l.lim_p, l.lim_m, l.dat_lim, a.datm,
                  a.datx, a.dni,
                  -DECODE (l.l_t, 2, a.ish_b, 4, a.ish_b, a.ish_k) ish,
                  -DECODE (l.l_t, 2, a.isr_b, 4, a.isr_b, a.isr_k) isr
             FROM cash_branch_limit l,
                  (SELECT branch, kv, dni, ish_k, ish_b, datm, datx,
                          DECODE (dni, 0, 0, ish_k / dni) isr_k,
                          DECODE (dni, 0, 0, ish_b / dni) isr_b
                     FROM (SELECT   branch, kv, COUNT (*) dni,
                                    SUM (ish_k) ish_k, SUM (ish_b) ish_b,
                                    MIN (cdat) datm, MAX (cdat) datx
                               FROM (SELECT   v.branch, v.kv, f.cdat,
                                                SUM (fost (v.acc, f.cdat)
                                                    )
                                              / 100 ish_k,
                                                SUM
                                                   (DECODE (nbs,
                                                            '1004', fost
                                                                       (v.acc,
                                                                        f.cdat
                                                                       ),
                                                            0
                                                           )
                                                   )
                                              / 100 ish_b
                                         FROM v_gl v,
                                              (SELECT c.num - 1 dd,
                                                      (d.dat1 + c.num - 1
                                                      ) cdat
                                                 FROM conductor c,
                                                      (SELECT TRUNC
                                                                 (TO_DATE
                                                                     (pul.get_mas_ini_val
                                                                         ('sFdat1'
                                                                         ),
                                                                      'dd.mm.yyyy'
                                                                     ),
                                                                  'MM'
                                                                 ) dat1
                                                         FROM DUAL) d
                                                WHERE TO_CHAR (d.dat1,
                                                               'yyyymm'
                                                              ) =
                                                         TO_CHAR ((  d.dat1
                                                                   + c.num
                                                                   - 1
                                                                  ),
                                                                  'yyyymm'
                                                                 )) f
                                        WHERE v.nbs IN
                                                 ('1001', '1002', '1004')
                                     GROUP BY v.branch, v.kv, f.cdat)
                           GROUP BY branch, kv)) a
            WHERE a.branch = l.branch
              AND a.kv = l.kv
              AND l.dat_lim =
                      (SELECT MAX (dat_lim)
                         FROM cash_branch_limit
                        WHERE branch = l.branch AND kv = l.kv AND l_t = l.l_t));

PROMPT *** Create  grants  V_CASH_BRANCH_LIMIT_PG ***
grant SELECT                                                                 on V_CASH_BRANCH_LIMIT_PG to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CASH_BRANCH_LIMIT_PG to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CASH_BRANCH_LIMIT_PG.sql =========***
PROMPT ===================================================================================== 
