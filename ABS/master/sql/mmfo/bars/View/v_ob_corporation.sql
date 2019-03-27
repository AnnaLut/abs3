

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB_CORPORATION.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB_CORPORATION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OB_CORPORATION ("CORPORATION_CODE", "CORPORATION_NAME", "EXTERNAL_ID", "ID", "PARENT_ID", "STATE_ID", "CORPORATION_STATE", "PARENT_NAME") AS 
  SELECT C.CORPORATION_CODE,
           C.CORPORATION_NAME,
           C.EXTERNAL_ID,
           C.ID,
           C.PARENT_ID,
           C.STATE_ID,
           CASE
                 WHEN state_id = 1 THEN 'Активний'
                 WHEN state_id = 2 THEN 'Заблоковано'
                 WHEN state_id = 3 THEN 'Закритий'
                 ELSE 'Невідомий тип'
           END AS CORPORATION_STATE,
           PRIOR C.CORPORATION_NAME AS PARENT_NAME
    FROM OB_CORPORATION C
    START WITH C.PARENT_ID IS NULL
    CONNECT BY PRIOR C.ID = C.PARENT_ID;

PROMPT *** Create  grants  V_OB_CORPORATION ***
grant SELECT                                                                 on V_OB_CORPORATION to BARSREADER_ROLE;
grant SELECT                                                                 on V_OB_CORPORATION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OB_CORPORATION to START1;
grant SELECT                                                                 on V_OB_CORPORATION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB_CORPORATION.sql =========*** End *
PROMPT ===================================================================================== 