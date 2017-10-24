
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_rez_acc.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_REZ_ACC (pdat_ IN DATE, pacc_ IN NUMBER)
   RETURN varchar2
IS
   racc_   varchar2(255);
BEGIN
  select max(acc)
  INTO racc_
  from (
     SELECT concatstr (ar.acc) acc
     FROM (SELECT   o.nbs_rez, o.ob22_rez, o.nbs_7f, o.ob22_7f, o.nbs_7r,
                    o.ob22_7r, o.pr, r.kv,
                       RTRIM (SUBSTR (r.tobo || '/',
                                      1,
                                      INSTR (r.tobo || '/', '/', 1, 3) - 1
                                     ),
                              '/'
                             )
                    || '/' branch,
                    SUM (NVL (r.sz1, sz)) sz,
                    DECODE (r.s080, 1, 1, 9, 9, 2) s080,
                    DECODE (r.s080, 1, 0, 9, 0, r.s080) r_s080, r.nls
               FROM tmp_rez_risk r
                    JOIN v_gl ac ON r.acc = ac.acc
                    JOIN specparam_int s ON r.acc = s.acc
                    JOIN srezerv_ob22 o
                    ON (    ac.nbs = o.nbs
                        AND s.ob22 = DECODE (o.ob22, '0', s.ob22, o.ob22)
                        AND DECODE (r.s080, 1, 1, 2) =
                               DECODE (o.s080,
                                       '0', DECODE (r.s080, 1, 1, 2),
                                       o.s080
                                      )
                        AND r.custtype =
                               DECODE (o.custtype,
                                       '0', r.custtype,
                                       o.custtype
                                      )
                        AND r.kv = DECODE (o.kv, '0', r.kv, o.kv)
                       )
                  AND r.acc = pacc_
              WHERE ID IN (SELECT userid
                             FROM rez_protocol
                            WHERE dat = pdat_)
                AND dat = pdat_
                AND NVL (r.sz1, sz) <> 0
           GROUP BY o.nbs_rez,
                    o.ob22_rez,
                    o.nbs_7f,
                    o.ob22_7f,
                    o.nbs_7r,
                    o.ob22_7r,
                    o.pr,
                    r.kv,
                       RTRIM (SUBSTR (r.tobo || '/',
                                      1,
                                      INSTR (r.tobo || '/', '/', 1, 3) - 1
                                     ),
                              '/'
                             )
                    || '/',
                    DECODE (r.s080, 1, 1, 9, 9, 2),
                    DECODE (r.s080, 1, 0, 9, 0, r.s080),
                    r.nls) t
          LEFT JOIN v_gl ar
          ON (    t.nbs_rez = ar.nbs
              AND t.ob22_rez = (SELECT ob22
                                  FROM specparam_int s
                                 WHERE s.acc = ar.acc)
              AND t.kv = ar.kv
              AND t.branch = ar.branch
              AND ar.dazs IS NULL
              and ar.ostq <> 0
              AND t.r_s080 =
                        DECODE (t.r_s080,
                                0, t.r_s080,
                                (SELECT s080
                                   FROM specparam s
                                  WHERE s.acc = ar.acc)
                               )));

   RETURN racc_;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_rez_acc.sql =========*** End *** 
 PROMPT ===================================================================================== 
 