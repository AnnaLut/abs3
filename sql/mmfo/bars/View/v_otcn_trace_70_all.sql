

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OTCN_TRACE_70_ALL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OTCN_TRACE_70_ALL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OTCN_TRACE_70_ALL ("REF", "KODF", "DATF", "KV", "SUMVAL", "COMM") AS 
  SELECT DISTINCT
          o.REF AS REF,
          o.KODF AS KODF,
          o.DATF AS DATF,
          o.KV AS KV,
          (SELECT ZNAP
             FROM otcn_trace_70
            WHERE     kodp LIKE '200%'
                  AND REF = o.REF
                  AND KODF = o.KODF
                  AND DATF = o.DATF
                  AND KV = o.KV
                  AND rownum=1)
             AS SumVal,
          TO_CHAR (NVL (o.ND, o.REF)) comm
     FROM otcn_trace_70 o
    WHERE o.kodp LIKE '100%' AND o.KODF = 'E2'
          AND NOT EXISTS
                     (SELECT 1
                        FROM NBUR_TMP_DEL_70
                       WHERE kodf = O.KODF
                             AND (REF = o.REF OR TO_CHAR (REF) = o.COMM))
   UNION ALL
   SELECT DISTINCT
          o.REF AS REF,
          o.KODF AS KODF,
          o.DATF AS DATF,
          o.KV AS KV,
          (SELECT ZNAP
             FROM otcn_trace_70
            WHERE     kodp LIKE '200%'
                  AND REF = o.REF
                  AND KODF = o.KODF
                  AND DATF = o.DATF
                  AND KV = o.KV)
             AS SumVal,
          TO_CHAR (NVL (o.ND, o.REF)) comm
     FROM otcn_trace_70 o
    WHERE o.kodp LIKE '100%' AND o.KODF = '70'
          AND NOT EXISTS
                     (SELECT 1
                        FROM NBUR_TMP_DEL_70
                       WHERE kodf = O.KODF
                             AND (REF = o.REF OR TO_CHAR (REF) = o.COMM))
   UNION ALL
   SELECT DISTINCT
          o.REF AS REF,
          o.KODF AS KODF,
          o.DATF AS DATF,
          o.KV AS KV,
          (SELECT ZNAP
             FROM otcn_trace_70
            WHERE     kodp LIKE '200%'
                  AND REF = o.REF
                  AND KODF = o.KODF
                  AND DATF = o.DATF
                  AND KV = o.KV)
             AS SumVal,
          TO_CHAR (NVL (o.ND, o.REF)) comm
     FROM otcn_trace_70 o
    WHERE o.kodp LIKE '100%' AND o.KODF = 'D3'
          AND NOT EXISTS
                     (SELECT 1
                        FROM NBUR_TMP_DEL_70
                       WHERE kodf = O.KODF
                             AND (REF = o.REF OR TO_CHAR (REF) = o.COMM))
   UNION ALL
   SELECT DISTINCT
          o.REF AS REF,
          o.KODF AS KODF,
          o.DATF AS DATF,
          o.KV AS KV,
          (SELECT ZNAP
             FROM otcn_trace_70
            WHERE     kodp LIKE '200%'
                  AND REF = o.REF
                  AND KODF = o.KODF
                  AND DATF = o.DATF
                  AND KV = o.KV)
             AS SumVal,
          TO_CHAR (NVL (o.ND, o.REF)) comm
     FROM otcn_trace_70 o
    WHERE o.kodp LIKE '100%' AND o.KODF = '2D'
          AND NOT EXISTS
                     (SELECT 1
                        FROM NBUR_TMP_DEL_70
                       WHERE kodf = O.KODF
                             AND (REF = o.REF OR TO_CHAR (REF) = o.COMM))
   UNION ALL
   SELECT DISTINCT o.REF AS REF,
                   o.KODF AS KODF,
                   o.DATF AS DATF,
                   TO_NUMBER (SUBSTR (o.KODP, 4, 3)) AS KV,
                   o.ZNAP AS SumVal,
                   TO_CHAR (NVL (o.ND, o.REF)) comm
     FROM otcn_trace_70 o
    WHERE o.kodp LIKE '71%' AND o.KODF = '2C' AND o.REF IS NOT NULL
          AND NOT EXISTS
                     (SELECT 1
                        FROM NBUR_TMP_DEL_70
                       WHERE kodf = O.KODF
                             AND (REF = o.REF OR TO_CHAR (REF) = o.COMM))
   UNION ALL
   SELECT DISTINCT R.REF AS REF,
                   o.KODF AS KODF,
                   o.DATF AS DATF,
                   R.KV AS KV,
                   TO_CHAR (ROUND (r.s / 100, 0)),
                   TO_CHAR (R.REF) COMM
     FROM otcn_trace_70 o, oper r
    WHERE o.kodp LIKE '100%' AND o.KODF = 'C9' AND o.REF = r.REF
          AND gl.p_icurval (r.kv, r.s, r.vdat) >
                 gl.p_icurval (840, 100000, r.vdat)
          AND NOT EXISTS
                 (SELECT 1
                    FROM NBUR_TMP_DEL_70
                   WHERE kodf = O.KODF AND REF = r.REF);

PROMPT *** Create  grants  V_OTCN_TRACE_70_ALL ***
grant SELECT                                                                 on V_OTCN_TRACE_70_ALL to BARSREADER_ROLE;
grant SELECT                                                                 on V_OTCN_TRACE_70_ALL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OTCN_TRACE_70_ALL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OTCN_TRACE_70_ALL.sql =========*** En
PROMPT ===================================================================================== 
