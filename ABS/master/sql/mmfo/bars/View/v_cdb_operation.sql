

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CDB_OPERATION.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_OPERATION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CDB_OPERATION ("ID", "DEAL_ID", "CLAIM_ID", "DEAL_NUMBER", "OPERATION_TYPE_ID", "OPERATION_TYPE", "SYS_TIME", "OPERATION_STATE_ID", "OPERATION_STATE") AS 
  select "ID","DEAL_ID","CLAIM_ID","DEAL_NUMBER","OPERATION_TYPE_ID","OPERATION_TYPE","SYS_TIME","OPERATION_STATE_ID","OPERATION_STATE" from cdb.v_cdb_operation;

PROMPT *** Create  grants  V_CDB_OPERATION ***
grant SELECT                                                                 on V_CDB_OPERATION to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CDB_OPERATION.sql =========*** End **
PROMPT ===================================================================================== 
