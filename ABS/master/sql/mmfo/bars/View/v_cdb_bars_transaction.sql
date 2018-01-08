

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CDB_BARS_TRANSACTION.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_BARS_TRANSACTION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CDB_BARS_TRANSACTION ("ID", "BRANCH_ID", "OBJECT_ID", "OPERATION_ID", "CLAIM_ID", "MFO", "OBJECT", "CLAIM_TYPE_ID", "CLAIM_TYPE", "OPERATION_TYPE_ID", "OPERATION_TYPE", "TRANSACTION_TYPE_ID", "TRANSACTION_TYPE", "PRIORITY_GROUP", "TRANSACTION_STATE_ID", "TRANSACTION_STATE", "FAIL_COUNTER", "LAST_TRACKING_MESSAGE") AS 
  select "ID","BRANCH_ID","OBJECT_ID","OPERATION_ID","CLAIM_ID","MFO","OBJECT","CLAIM_TYPE_ID","CLAIM_TYPE","OPERATION_TYPE_ID","OPERATION_TYPE","TRANSACTION_TYPE_ID","TRANSACTION_TYPE","PRIORITY_GROUP","TRANSACTION_STATE_ID","TRANSACTION_STATE","FAIL_COUNTER","LAST_TRACKING_MESSAGE" from cdb.v_cdb_bars_transaction;

PROMPT *** Create  grants  V_CDB_BARS_TRANSACTION ***
grant SELECT                                                                 on V_CDB_BARS_TRANSACTION to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CDB_BARS_TRANSACTION.sql =========***
PROMPT ===================================================================================== 
