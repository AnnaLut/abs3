

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CHECK_ACCOUNT_PARAMS_ROW.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CHECK_ACCOUNT_PARAMS_ROW ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CHECK_ACCOUNT_PARAMS_ROW ("ACC", "ISP", "NBS", "NLS", "KV", "RNK", "BRANCH", "ERR_TXT") AS 
  SELECT acc,
          isp,
          nbs,
          nls,
          kv,
          rnk,
          branch,
          TRIM(   TRIM (s080)
               || ' '
               || TRIM (s260)
               || ' '
               || TRIM (r013)
               || ' '
               || TRIM (r013_1)
               || ' '
               || TRIM (s270)
               || ' '
               || TRIM (pawn)
               || ' '
               || TRIM (pawn)
               || ' '
               || TRIM (check_a7))
             err_txt
     FROM (SELECT a.acc,
                  a.isp,
                  a.nbs,
                  a.nls,
                  a.kv,
                  a.rnk,
                  a.BRANCH,
                  CASE
                     WHEN (    (s.s080 IS NULL)
                           AND k.r020 IS NOT NULL
                           AND a.OSTC < 0)
                     THEN
                        'Не заполнен параметр S080'
                     ELSE
                        NULL
                  END
                     s080,
                  CASE
                     WHEN (    (s.s260 IS NULL)
                           AND k.r020 IS NOT NULL
                           AND a.OSTC < 0)
                     THEN
                        'Не заполнен параметр S260'
                     ELSE
                        NULL
                  END
                     s260,
                  CASE
                     WHEN (    (s.r013 IS NULL)
                           AND k1.r020 IS NOT NULL
                           AND a.OSTC < 0)
                     THEN
                        'Не заполнен параметр R013'
                     ELSE
                        NULL
                  END
                     r013,
                  CASE
                     WHEN (    s.r013 IS NOT NULL
                           AND k1.r020 IS NOT NULL
                           AND a.OSTC < 0
                           AND INSTR (k1.r013, s.r013) = 0)
                     THEN
                        'Недопустимый параметр R013 - '
                        || s.r013
                        || ' (Возможные - '
                        || k1.r013
                        || ')'
                     ELSE
                        NULL
                  END
                     r013_1,
                  CASE
                     WHEN (    s.s270 IS NOT NULL
                           AND k3.r020 IS NOT NULL
                           AND a.OSTC < 0
                           AND INSTR (k3.s270, s.s270) = 0)
                     THEN
                        'Недопустимый параметр S270 - '
                        || s.s270
                        || ' (Возможные - '
                        || k3.s270
                        || ')'
                     ELSE
                        NULL
                  END
                     s270,
                  CASE
                     WHEN (p.acc IS NOT NULL AND p.pawn IS NULL)
                     THEN
                        'Не заполнен параметр PAWN (вид обеспечения) '
                     ELSE
                        NULL
                  END
                     pawn,
                  CASE
                     WHEN (    p.acc IS NOT NULL
                           AND p.pawn IS NOT NULL
                           AND INSTR (cp.pawn, p.pawn) = 0)
                     THEN
                        'Недопустимый параметр PAWN (вид обеспечения) - '
                        || p.pawn
                        || ' (Возможные - '
                        || cp.pawn
                        || ')'
                     ELSE
                        NULL
                  END
                     pawn_1,
                  CASE
                     WHEN (pa7.tag IS NOT NULL OR pa7.val IS NOT NULL)
                     THEN
                        val
                     ELSE
                        NULL
                  END
                     check_a7
             FROM accounts a
                  LEFT JOIN specparam s
                     ON a.acc = s.acc
                  LEFT JOIN (  SELECT r020
                                 FROM kod_r020
                                WHERE a010 = '11' AND prem = 'КБ '
                                      AND NVL (
                                            d_close,
                                            TO_DATE ('01014000', 'ddmmyyyy')) >
                                            TRUNC (SYSDATE)
                             GROUP BY r020) k
                     ON a.nbs = k.r020
                  LEFT JOIN (  SELECT r020, ConcatStr (TO_CHAR (r013)) r013
                                 FROM kl_r013
                                WHERE NVL (d_close,
                                           TO_DATE ('01014000', 'ddmmyyyy')) >
                                         TRUNC (SYSDATE)
                             GROUP BY r020) k1
                     ON a.nbs = k1.r020
                  LEFT JOIN (  SELECT r020,
                                      (SELECT ConcatStr (TO_CHAR (s270))
                                         FROM kl_s270)
                                         s270
                                 FROM kod_r020
                                WHERE a010 = 'D5' AND prem = 'КБ '
                                      AND NVL (
                                            d_close,
                                            TO_DATE ('01014000', 'ddmmyyyy')) >
                                            TRUNC (SYSDATE)
                             GROUP BY r020) k3
                     ON a.nbs = k3.r020
                  LEFT JOIN pawn_acc p
                     ON a.acc = p.acc
                  LEFT JOIN (  SELECT nbsz r020, ConcatStr (pawn) pawn
                                 FROM cc_pawn
                             GROUP BY nbsz) cp
                     ON a.nbs = cp.r020
                  LEFT JOIN (SELECT acc,
                                    nbuc,
                                    isp,
                                    SUBSTR (nls, 1, 4) nbs,
                                    nls,
                                    kv,
                                    rnk,
                                    '240' tag,
                                    'Не заполнен параметр S240'
                                       val
                               FROM rnbu_trace
                              WHERE SUBSTR (kodp, 8, 1) = '0') pa7
                     ON a.acc = pa7.acc
            WHERE NVL (a.dazs, TO_DATE ('01014000', 'ddmmyyyy')) > bankdate
                  AND ( (    (s.s080 IS NULL OR s.s260 IS NULL)
                         AND k.r020 IS NOT NULL
                         AND a.OSTC < 0)
                       OR (    s.r013 IS NULL
                           AND k1.r020 IS NOT NULL
                           AND a.OSTC < 0)
                       OR (    s.r013 IS NOT NULL
                           AND k1.r020 IS NOT NULL
                           AND a.OSTC < 0
                           AND INSTR (k1.r013, s.r013) = 0)
                       OR (    s.s270 IS NOT NULL
                           AND k3.r020 IS NOT NULL
                           AND a.OSTC < 0
                           AND INSTR (k3.s270, s.s270) = 0)
                       OR (p.acc IS NOT NULL AND p.pawn IS NULL)
                       OR (    p.acc IS NOT NULL
                           AND p.pawn IS NOT NULL
                           AND INSTR (cp.pawn, p.pawn) = 0)));

PROMPT *** Create  grants  V_CHECK_ACCOUNT_PARAMS_ROW ***
grant SELECT                                                                 on V_CHECK_ACCOUNT_PARAMS_ROW to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CHECK_ACCOUNT_PARAMS_ROW to RPBN002;
grant SELECT                                                                 on V_CHECK_ACCOUNT_PARAMS_ROW to TECH005;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CHECK_ACCOUNT_PARAMS_ROW.sql ========
PROMPT ===================================================================================== 
