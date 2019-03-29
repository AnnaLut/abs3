CREATE OR REPLACE PROCEDURE BARS.PRVN_ITOG_PROC is

 begin
    z23.to_log_rez (user_id , 351 , TRUNC (SYSDATE, 'MM') ,'(DEL)');
    delete from prvn_itog_r;
    delete from prvn_itog_r1;
    delete from prvn_itog_k;    
    delete from prvn_itog_k1;    
    delete from prvn_itog_d;    
    delete from prvn_itog_d1;    
    delete from prvn_itog_p;    
    delete from prvn_itog_p1;    
    delete from prvn_itog_f;    
    delete from prvn_itog_f1;
    z23.to_log_rez (user_id , 351 , TRUNC (SYSDATE, 'MM') ,'(R)');
    insert into prvn_itog_r (fdat, fdat1, kv, bv, bvq, rez23, rezq23, rez,rezq)
    SELECT fdat,
           ADD_MONTHS (fdat, -1) FDAT1,
           KV,
           SUM (bv) bv,
           SUM (bvq) bvq,
           SUM (rez23) rez23,
           SUM (rezq23) rezq23,
           SUM (rez) rez,
           SUM (rezq) rezq
    FROM   nbu23_rez
    WHERE  bv > 0
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -1)
      AND  fdat < SYSDATE
    GROUP BY fdat, kv
    UNION ALL
    SELECT fdat,
           ADD_MONTHS (fdat, -1),
           0,
           NULL,
           SUM (bvq),
           NULL,
           SUM (rezq23),
           NULL,
           SUM (rezq)
    FROM   nbu23_rez
    WHERE  bv > 0
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -1)
      AND  fdat < SYSDATE
    GROUP BY fdat;
    z23.to_log_rez (user_id , 351 , TRUNC (SYSDATE, 'MM') ,'(R1)');
    insert into prvn_itog_r1 (fdat, kv, bv, bvq, rez23, rezq23, rez,rezq)
    SELECT fdat,
           KV,
           SUM (bv) bv,
           SUM (bvq) bvq,
           SUM (rez23) rez23,
           SUM (rezq23) rezq23,
           SUM (rez) rez,
           SUM (rezq) rezq
    FROM   nbu23_rez
    WHERE  bv > 0
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -1)
      AND  fdat < SYSDATE
    GROUP BY fdat, kv
    UNION ALL
    SELECT fdat,
           0,
           NULL,
           SUM (bvq),
           NULL,
           SUM (rezq23),
           NULL,
           SUM (rezq)
    FROM   nbu23_rez
    WHERE  bv > 0
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -1)
      AND  fdat < SYSDATE
    GROUP BY fdat;
    z23.to_log_rez (user_id , 351 , TRUNC (SYSDATE, 'MM') ,'(K)');
    insert into prvn_itog_k (fdat, kv, sna, snaq)
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           a.kv,
           SUM (m.ost + m.CRkos - m.CRdos) / 100 SNA,
           SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100 SNAQ
    FROM   AGG_MONBALS m, accounts a
    WHERE  a.tip = 'SNA'
      AND  a.nbs IS NOT NULL
      AND  m.acc = a.acc
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
           GROUP BY m.fdat, a.kv
    UNION ALL
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           0,
           NULL,
           SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100
    FROM   AGG_MONBALS m, accounts a
    WHERE  a.tip = 'SNA'
      AND  a.nbs IS NOT NULL
      AND  m.acc = a.acc
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
    GROUP BY m.fdat;
    z23.to_log_rez (user_id , 351 , TRUNC (SYSDATE, 'MM') ,'(K1)');
    insert into prvn_itog_k1 (fdat, kv, sna, snaq)
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           a.kv,
           SUM (m.ost + m.CRkos - m.CRdos) / 100 SNA,
           SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100 SNAQ
    FROM   AGG_MONBALS m, accounts a
    WHERE  a.tip = 'SNA'
      AND  a.nbs IS NOT NULL
      AND  m.acc = a.acc
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
    GROUP BY m.fdat, a.kv
    UNION ALL
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           0,
           NULL,
           SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100
    FROM   AGG_MONBALS m, accounts a
    WHERE  a.tip = 'SNA'
      AND  a.nbs IS NOT NULL
      AND  m.acc = a.acc
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
    GROUP BY m.fdat;
    z23.to_log_rez (user_id , 351 , TRUNC (SYSDATE, 'MM') ,'(D)');
    insert into prvn_itog_d (fdat, kv, sdi, sdiq)
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           a.kv,
           SUM (m.ost + m.CRkos - m.CRdos) / 100 SDI,
           SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100 SDIQ
    FROM   AGG_MONBALS m,
          (SELECT * FROM accounts
           WHERE    SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip WHERE tip = 'SDI')
            AND     acc NOT IN (SELECT acc FROM accounts
                                WHERE  accc IS NOT NULL
                                  AND  SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip WHERE tip = 'SDI')))  a
    WHERE  m.acc = a.acc
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
      AND  m.ost + m.CRkos - m.CRdos > 0
    GROUP BY m.fdat, a.kv
    UNION ALL
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           0,
           NULL,
           SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100
    FROM AGG_MONBALS m,
        (SELECT * FROM accounts
         WHERE    SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip WHERE tip = 'SDI')
           AND    acc NOT IN (SELECT acc FROM accounts
                              WHERE  accc IS NOT NULL
                                AND  SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip  WHERE tip = 'SDI')))  a
    WHERE  m.acc = a.acc
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
      AND  m.ost + m.CRkos - m.CRdos > 0
    GROUP BY m.fdat;
    z23.to_log_rez (user_id , 351 , TRUNC (SYSDATE, 'MM') ,'(D1)');
    insert into prvn_itog_d1 (fdat, kv, sdi, sdiq)
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           a.kv,
           SUM (m.ost + m.CRkos - m.CRdos) / 100 SDI,
           SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100 SDIQ
    FROM   AGG_MONBALS m,
          (SELECT * FROM accounts
           WHERE    SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip  WHERE tip = 'SDI')
             AND    acc NOT IN (SELECT acc FROM accounts
                                WHERE  accc IS NOT NULL
                                  AND  SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip  WHERE tip = 'SDI')))  a
    WHERE  m.acc = a.acc
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
      AND  m.ost + m.CRkos - m.CRdos > 0
    GROUP BY m.fdat, a.kv
    UNION ALL
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           0,
           NULL,
           SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100
    FROM   AGG_MONBALS m,
          (SELECT *  FROM accounts
           WHERE     SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip WHERE tip = 'SDI')
             AND     acc NOT IN (SELECT acc FROM accounts
                                 WHERE  accc IS NOT NULL
                                   AND  SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip WHERE tip = 'SDI')))  a
    WHERE  m.acc = a.acc
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
      AND  m.ost + m.CRkos - m.CRdos > 0
    GROUP BY m.fdat;
    z23.to_log_rez (user_id , 351 , TRUNC (SYSDATE, 'MM') ,'(P)');
    insert into PRVN_ITOG_P (fdat, kv, ucenka, ucenkaq)
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           a.kv,
           NVL (SUM (m.ost + m.CRkos - m.CRdos) / 100, 0) UCENKA,
           NVL (SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100, 0) UCENKAQ
    FROM   AGG_MONBALS m,
          (SELECT * FROM accounts
           WHERE    SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip  WHERE tip = 'SRR')
             AND    acc NOT IN (SELECT acc FROM accounts
                                WHERE  accc IS NOT NULL
                                  AND  SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip  WHERE tip = 'SRR'))) a
    WHERE  m.acc = a.acc
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
      AND (m.ost + m.CRkos - m.CRdos > 0  OR a.rnk = 90593701 AND m.ost + m.CRkos - m.CRdos < 0)
    GROUP BY m.fdat, a.kv
    UNION ALL
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           0,
           NULL,
           ROUND (SUM (m.ostQ + m.CRkosQ - m.CRdosQ), 0) / 100
    FROM   AGG_MONBALS m,
          (SELECT * FROM accounts
           WHERE    SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip WHERE tip = 'SRR')
             AND    acc NOT IN (SELECT acc FROM accounts
                                WHERE  accc IS NOT NULL
                                  AND  SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip WHERE tip = 'SRR')))  a
    WHERE  m.acc = a.acc
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
      AND (m.ost + m.CRkos - m.CRdos > 0  OR a.rnk = 90593701 AND m.ost + m.CRkos - m.CRdos < 0)
    GROUP BY m.fdat;
    z23.to_log_rez (user_id , 351 , TRUNC (SYSDATE, 'MM') ,'(P1)');
    insert into PRVN_ITOG_P1 (fdat, kv, ucenka, ucenkaq)
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           a.kv,
           NVL (SUM (m.ost + m.CRkos - m.CRdos) / 100, 0) UCENKA,
           NVL (SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100, 0) UCENKAQ
    FROM   AGG_MONBALS m,
          (SELECT * FROM accounts
           WHERE    SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip  WHERE tip = 'SRR')
             AND    acc NOT IN (SELECT acc FROM accounts
                                WHERE  accc IS NOT NULL
                                  AND  SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip  WHERE tip = 'SRR'))) a
    WHERE  m.acc = a.acc
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
      AND (m.ost + m.CRkos - m.CRdos > 0  OR a.rnk = 90593701 AND m.ost + m.CRkos - m.CRdos < 0)
    GROUP BY m.fdat, a.kv
    UNION ALL
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           0,
           NULL,
           ROUND (SUM (m.ostQ + m.CRkosQ - m.CRdosQ), 0) / 100
    FROM   AGG_MONBALS m,
          (SELECT * FROM accounts
           WHERE    SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip WHERE tip = 'SRR')
             AND    acc NOT IN (SELECT acc FROM accounts
                                WHERE  accc IS NOT NULL
                                  AND  SUBSTR (nls, 1, 4) IN (SELECT nbs FROM bpk_nbs_tip WHERE tip = 'SRR')))  a
    WHERE  m.acc = a.acc
      AND  fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
      AND (m.ost + m.CRkos - m.CRdos > 0  OR a.rnk = 90593701 AND m.ost + m.CRkos - m.CRdos < 0)
    GROUP BY m.fdat;
    z23.to_log_rez (user_id , 351 , TRUNC (SYSDATE, 'MM') ,'(F)');
    insert into prvn_itog_f (fdat, kv, sdf, sdfq)
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           a.kv,
           SUM (m.ost + m.CRkos - m.CRdos) / 100 SDF,
           SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100 SDFQ
    FROM   AGG_MONBALS m, (SELECT * FROM nbu23_rez WHERE fdat = TRUNC (SYSDATE, 'MM') AND arjk = 1  AND  tip = 'SDF') a
    WHERE  m.acc = a.acc
      AND  m.fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
      AND  m.ost + m.CRkos - m.CRdos > 0
    GROUP BY m.fdat, a.kv
    UNION ALL
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           0,
           NULL,
           SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100
    FROM   AGG_MONBALS m, (SELECT * FROM nbu23_rez WHERE fdat = TRUNC (SYSDATE, 'MM') AND arjk = 1  AND tip = 'SDF') a
    WHERE  m.acc = a.acc
      AND  m.fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
      AND  m.ost + m.CRkos - m.CRdos > 0
    GROUP BY m.fdat;
    z23.to_log_rez (user_id , 351 , TRUNC (SYSDATE, 'MM') ,'(F1)');
    insert into prvn_itog_f1 (fdat, kv, sdf, sdfq)
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           a.kv,
           SUM (m.ost + m.CRkos - m.CRdos) / 100 SDF,
           SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100 SDFQ
    FROM   AGG_MONBALS m, (SELECT * FROM nbu23_rez WHERE fdat = TRUNC (SYSDATE, 'MM') AND arjk = 1  AND  tip = 'SDF') a
    WHERE  m.acc = a.acc
      AND  m.fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
      AND  m.ost + m.CRkos - m.CRdos > 0
    GROUP BY m.fdat, a.kv
    UNION ALL
    SELECT ADD_MONTHS (m.fdat, 1) fdat,
           0,
           NULL,
           SUM (m.ostQ + m.CRkosQ - m.CRdosQ) / 100
    FROM   AGG_MONBALS m, (SELECT * FROM nbu23_rez WHERE fdat = TRUNC (SYSDATE, 'MM') AND arjk = 1  AND tip = 'SDF') a
    WHERE  m.acc = a.acc
      AND  m.fdat > ADD_MONTHS (TRUNC (SYSDATE, 'YYYY'), -2)
      AND  m.ost + m.CRkos - m.CRdos > 0
    GROUP BY m.fdat;
 
end;
/
show err;

PROMPT *** Create  grants  PRVN_ITOG_PROC ***
grant EXECUTE                                                                on PRVN_ITOG_PROC      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PRVN_ITOG_PROC      to RCC_DEAL;
grant EXECUTE                                                                on PRVN_ITOG_PROC      to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PRVN_ITOG_PROC.sql =========*** End **
PROMPT ===================================================================================== 
