PROMPT ===============================================================================
PROMPT *** Run *** == Scripts /Sql/BARS/View/V_SMB_DEPOSIT_ACTIVITY.sql == *** Run ***
PROMPT =============================================================================== 

PROMPT *** Create  view V_SMB_DEPOSIT_ACTIVITY  ***

create or replace force view v_smb_deposit_activity 
as
with prc_state as(
        select i.list_item_id
              ,i.list_item_name
              ,i.list_item_code   
          from list_type t
              ,list_item i 
         where t.list_code = 'PROCESS_STATE'
           and t.id = i.list_type_id),
   act_state as(
        select i.list_item_id
              ,i.list_item_name
              ,i.list_item_code   
          from list_type t
              ,list_item i 
         where t.list_code = 'PROCESS_ACTIVITY_STATE'
           and t.id = i.list_type_id), 
  obj as(
        select --+ use_concat(or_predicates(1))
               o.id object_id
              ,o.object_type_id
              ,ot.type_code object_type_code
              ,ot.type_name object_type_name
              ,o.state_id object_state_id 
          from object_type ot
              ,object o
         where ot.type_code in ('SMB_DEPOSIT_ON_DEMAND', 'SMB_DEPOSIT_TRANCHE')
           and ot.id = o.object_type_id)
            select o.object_id
                  ,o.object_type_id
                  ,o.object_type_code
                  ,o.object_type_name
                  ,o.object_state_id 
                  ,p.id process_id
                  ,p.process_type_id
                  ,p.process_name
                  ,pt.module_code
                  ,pt.process_code
                  ,p.state_id process_state_id
                  ,prc_state.list_item_name process_state_name
                  ,prc_state.list_item_code process_state_code
                  ,max(ph.id) keep (dense_rank last order by ph.sys_time) process_history_id
                  ,max(ph.comment_text) keep (dense_rank last order by ph.sys_time) process_history_text
                  ,max(ph.sys_time) keep (dense_rank last order by ph.sys_time) process_history_sys_time
                  ,max(ph.user_id) keep (dense_rank last order by ph.sys_time) process_history_user_id
                  ,a.id activity_id
                  ,a.activity_type_id
                  ,a.activity_name
                  ,pw.activity_code
                  ,a.state_id activity_state_id
                  ,act_state.list_item_name activity_state_name
                  ,act_state.list_item_code activity_state_code
                  ,max(ah.id) keep (dense_rank last order by ah.sys_time) activity_history_id
                  ,max(ah.comment_text) keep (dense_rank last order by ah.sys_time) activity_history_text
                  ,max(ah.sys_time) keep (dense_rank last order by ah.sys_time) activity_history_sys_time
                  ,max(ah.user_id) keep (dense_rank last order by ah.sys_time) activity_history_user_id
              from obj o
                  ,process p
                  ,process_type pt  
                  ,process_history ph  
                  ,activity a 
                  ,process_workflow pw
                  ,activity_history ah
                  ,prc_state 
                  ,act_state
             where 1 = 1 
               and o.object_id = p.object_id
               and p.process_type_id = pt.id 
               and p.id = ph.process_id 
               and p.id= a.process_id(+)
               and a.activity_type_id = pw.id(+)
               and a.id = ah.activity_id(+)
               and p.state_id = prc_state.list_item_id
               and a.state_id = act_state.list_item_id(+)
            group by o.object_id
                    ,o.object_type_id
                    ,o.object_type_code
                    ,o.object_type_name
                    ,o.object_state_id             
                    ,p.id
                    ,p.process_type_id
                    ,p.process_name
                    ,pt.module_code
                    ,pt.process_code
                    ,p.state_id
                    ,a.id
                    ,a.activity_type_id
                    ,a.activity_name
                    ,pw.activity_code
                    ,a.state_id         
                    ,prc_state.list_item_name
                    ,prc_state.list_item_code
                    ,act_state.list_item_name
                    ,act_state.list_item_code
;                    
                    
PROMPT *** Create  grants  V_SMB_DEPOSIT_ACTIVITY ***
grant SELECT  on v_smb_deposit_activity  to BARSREADER_ROLE;
grant SELECT  on v_smb_deposit_activity  to BARS_ACCESS_DEFROLE;

PROMPT ===============================================================================
PROMPT *** End *** == Scripts /Sql/BARS/View/V_SMB_DEPOSIT_ACTIVITY.sql == *** End ***
PROMPT ===============================================================================