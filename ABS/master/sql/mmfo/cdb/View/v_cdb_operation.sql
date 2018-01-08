

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/View/V_CDB_OPERATION.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CDB_OPERATION ***

  CREATE OR REPLACE FORCE VIEW CDB.V_CDB_OPERATION ("ID", "DEAL_ID", "CLAIM_ID", "DEAL_NUMBER", "OPERATION_TYPE_ID", "OPERATION_TYPE", "SYS_TIME", "OPERATION_STATE_ID", "OPERATION_STATE") AS 
  select o.id,
       o.deal_id,
       o.claim_id,
       d.deal_number,
       o.operation_type operation_type_id,
       ot.enumeration_name operation_type,
       o.sys_time,
       o.state operation_state_id,
       os.enumeration_code operation_state
from   operation o
join   deal d on d.id = o.deal_id
left join claim c on c.id = o.claim_id
left join enumeration_value ot on ot.enumeration_type_id = 301 /*cdb_dispatcher.ET_OPERATION_TYPE*/ and
                                  ot.enumeration_id = o.operation_type
left join enumeration_value os on os.enumeration_type_id = 302 /*cdb_dispatcher.ET_OPEATION_STATE*/ and
                                  os.enumeration_id = o.state;

PROMPT *** Create  grants  V_CDB_OPERATION ***
grant SELECT                                                                 on V_CDB_OPERATION to BARSREADER_ROLE;
grant SELECT                                                                 on V_CDB_OPERATION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CDB_OPERATION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/View/V_CDB_OPERATION.sql =========*** End ***
PROMPT ===================================================================================== 
