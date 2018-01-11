

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPU_RELATION_ACC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPU_RELATION_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPU_RELATION_ACC ("GEN_ID", "GEN_ACC", "TIP_ACC", "DEP_ID", "DEP_ACC") AS 
  SELECT GEN_ID,
         GEN_ACC,
         TIP_ACC,
         DEP_ID,
         DEP_ACC
    FROM ( WITH deals AS ( SELECT dpu_id, acc, NVL (dpu_gen, 0) AS dpu_gen
                             FROM BARS.DPU_DEAL d
                            WHERE d.closed = 0
                              AND EXISTS ( SELECT 1 FROM DPU_VIDD v WHERE v.vidd = d.vidd AND fl_extend = 2 ) ),
                acras AS ( SELECT acc, acra
                             FROM int_accn i
                            WHERE ( acc, id ) IN (SELECT acc, 1 FROM deals) )
           SELECT g.dpu_id AS GEN_ID,
                  g.acc    AS GEN_ACC,
                  'DEP'    AS TIP_ACC,
                  d.dpu_id AS DEP_ID,
                  d.acc    AS DEP_ACC
             FROM DEALS g
             LEFT JOIN DEALS d  ON ( d.dpu_gen = g.dpu_id )
            WHERE g.dpu_gen = 0
            UNION ALL
           SELECT g.dpu_id,
                  gi.acra,
                  'DEN',
                  d.dpu_id,
                  di.acra
             FROM DEALS g
            INNER JOIN acras gi ON ( g.acc     = gi.acc   )
             LEFT JOIN DEALS d  ON ( d.dpu_gen = g.dpu_id )
             LEFT JOIN acras di ON ( d.acc     = di.acc   )
            WHERE g.dpu_gen = 0 );

PROMPT *** Create  grants  V_DPU_RELATION_ACC ***
grant SELECT                                                                 on V_DPU_RELATION_ACC to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPU_RELATION_ACC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPU_RELATION_ACC to DPT_ROLE;
grant SELECT                                                                 on V_DPU_RELATION_ACC to START1;
grant SELECT                                                                 on V_DPU_RELATION_ACC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPU_RELATION_ACC.sql =========*** End
PROMPT ===================================================================================== 
