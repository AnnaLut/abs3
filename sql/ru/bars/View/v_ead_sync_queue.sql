

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EAD_SYNC_QUEUE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EAD_SYNC_QUEUE ***

  CREATE OR REPLACE VIEW BARS.V_EAD_SYNC_QUEUE AS
  select sq.id as sync_id,
       sq.crt_date,
       sq.type_id,
       t.name           as type_name,
       sq.obj_id,
                        case when type_id in ('CLIENT','UCLIENT','ACT') then OBJ_ID
                 when type_id in ('AGR') then 
                  case when substr(obj_id, 0, instr(obj_id,';')-1) ='DPT' 
                       then (select to_char(rnk) from dpt_deposit_clos where deposit_id = substr(obj_id, instr(obj_id,';')+1, length(obj_id)) and action_id = 0)
                       when substr(obj_id, 0, instr(obj_id,';')-1) ='WAY' 
                       then (select to_char(a.rnk) from w4_acc wa, accounts a where wa.nd = substr(obj_id, instr(obj_id,';')+1, length(obj_id)) and a.acc = wa.acc_pk)
                       when substr(obj_id, 0, instr(obj_id,';')-1) in ('ACC') 
                       then (select to_char(rnk) from accounts where acc = substr(obj_id, instr(obj_id,';')+1, length(obj_id)))                  
                  end
                 when type_id in ('UAGR') then 
                  case when substr(obj_id, 0, instr(obj_id,';')-1) ='DPT' 
                       then (select to_char(rnk) from dpu_deal where dpu_id = substr(obj_id, instr(obj_id,';')+1, length(obj_id)))
                       when substr(obj_id, 0, instr(obj_id,';')-1) ='WAY' 
                       then (select to_char(a.rnk) from w4_acc wa, accounts a where wa.nd = substr(obj_id, instr(obj_id,';')+1, length(obj_id)) and a.acc = wa.acc_pk)
                       when substr(obj_id, 0, instr(obj_id,';')-1) in ('ACC') 
                       then (select to_char(rnk) from accounts where acc = substr(obj_id, instr(obj_id,';')+1, length(obj_id)))                  
                  end
                 when type_id in ('DOC') then (select to_char(rnk) from ead_docs where ID = obj_id)
                 when type_id in ('ACC') then 
                        case when substr(obj_id, 0, instr(obj_id,';')-1) in ('DPT','ACC') 
                        then (select to_char(rnk) from accounts where acc = REGEXP_SUBSTR(substr(obj_id, instr(obj_id,';')+1, length(obj_id)), '[^;]+'))
                        end
            end as rnk,
       sq.status_id,
       s.name           as status_name,
       sq.err_text,
       sq.err_count,
       sq.message_id,
       sq.message_date,
       sq.responce_id,
       sq.responce_date
  from ead_sync_queue sq, ead_types t, ead_statuses s
 where sq.crt_date > sysdate - interval '15' day
   and sq.type_id = t.id
   and sq.status_id = s.id
 order by sq.id desc;

PROMPT *** Create  grants  V_EAD_SYNC_QUEUE ***
grant SELECT                                                                 on V_EAD_SYNC_QUEUE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EAD_SYNC_QUEUE.sql =========*** End *
PROMPT ===================================================================================== 
