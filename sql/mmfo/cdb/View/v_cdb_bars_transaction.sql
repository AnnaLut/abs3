

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/View/V_CDB_BARS_TRANSACTION.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_BARS_TRANSACTION ***

  CREATE OR REPLACE FORCE VIEW CDB.V_CDB_BARS_TRANSACTION ("ID", "BRANCH_ID", "OBJECT_ID", "OPERATION_ID", "CLAIM_ID", "MFO", "OBJECT", "CLAIM_TYPE_ID", "CLAIM_TYPE", "OPERATION_TYPE_ID", "OPERATION_TYPE", "TRANSACTION_TYPE_ID", "TRANSACTION_TYPE", "PRIORITY_GROUP", "TRANSACTION_STATE_ID", "TRANSACTION_STATE", "FAIL_COUNTER", "LAST_TRACKING_MESSAGE") AS 
  select bt.id,
       bo.branch_id,
       bt.object_id,
       bt.operation_id,
       o.claim_id,
       (select b.branch_code
        from   branch b
        where  b.id = bo.branch_id) mfo,
       case when bo.object_type = 1 /*cdb_bars_object.OBJ_TYPE_ACCOUNT*/ then
                 (select ba.account_number
                  from   bars_account ba
                  where  ba.id = bo.id)
            when bo.object_type = 4 /*cdb_bars_object.OBJ_TYPE_OPERATION*/ then
                 (select substr(bd.purpose, 1, 200)
                  from   bars_document bd
                  where  bd.id = bo.id)
            when bo.object_type in (2 /*cdb_bars_object.OBJ_TYPE_DEPOSIT*/, 3 /*cdb_bars_object.OBJ_TYPE_LOAN*/) then
                 d.deal_number
            else null
       end object,
       c.claim_type_id,
       (select ct.enumeration_name
        from   enumeration_value ct
        where  ct.enumeration_type_id = 102 /*cdb_claim.ET_CLAIM_TYPE*/ and
               ct.enumeration_id = c.claim_type_id) claim_type,
       o.operation_type operation_type_id,
       (select ot.enumeration_name
        from   enumeration_value ot
        where  ot.enumeration_type_id = 301 /*cdb_dispatcher.ET_OPERATION_TYPE*/ and
               ot.enumeration_id = o.operation_type) operation_type,
       bt.transaction_type transaction_type_id,
       (select ttp.enumeration_name
        from   enumeration_value ttp
        where  ttp.enumeration_type_id = 402 /*cdb_bars_client.ET_TRANSACTION_TYPE*/ and
               ttp.enumeration_id = bt.transaction_type) transaction_type,
       bt.priority_group,
       bt.state transaction_state_id,
       (select ts.enumeration_code
        from   enumeration_value ts
        where  ts.enumeration_type_id = 401 /*cdb_bars_client.ET_TRANSACTION_STATE*/ and
               ts.enumeration_id = bt.state) transaction_state,
       bt.fail_counter,
       (select min(dbms_lob.substr(tt.error_message, 4000)) keep (dense_rank last order by tt.id)
        from   transaction_tracking tt
        where  tt.transaction_id = bt.id) last_tracking_message
from   bars_transaction bt
left join operation o on o.id = bt.operation_id
left join claim c on c.id = o.claim_id
left join bars_object bo on bo.id = bt.object_id
left join deal d on d.id = bo.deal_id
where bt.sys_time >= (trunc(sysdate) - 7) or
      bt.state not in (2 /*cdb_bars_client.TRAN_STATE_COMPLETED*/, 4 /*cdb_bars_client.TRAN_STATE_CANCELED*/);

PROMPT *** Create  grants  V_CDB_BARS_TRANSACTION ***
grant SELECT                                                                 on V_CDB_BARS_TRANSACTION to BARSREADER_ROLE;
grant SELECT                                                                 on V_CDB_BARS_TRANSACTION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CDB_BARS_TRANSACTION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/View/V_CDB_BARS_TRANSACTION.sql =========*** 
PROMPT ===================================================================================== 
