PROMPT ==================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_REGISTER_HISTORY.sql ==*** Run
PROMPT ==================================================================================== 

PROMPT *** Create  trigger TAIU_REGISTER_HISTORY ***

create or replace trigger taiu_register_history
after insert or update ON register_history
for each row
declare
    l_operation_type varchar2(1);
begin
  l_operation_type := case when inserting then 'I' else 'U' end;
  insert into register_log(
             id 
            ,operation_type      
            ,register_value_id   
            ,register_type_id    
            ,object_id           
            ,register_history_id 
            ,plan_value          
            ,actual_value        
            ,currency_id         
            ,value_date          
            ,amount              
            ,is_active           
            ,is_planned   
            ,document_id
            ,local_bank_date
            ,global_bank_date
            ,user_id
            ,sys_time)
  values (
             register_log_seq.nextval 
            ,l_operation_type      
            ,:new.register_value_id   
            ,null    
            ,null           
            ,:new.id 
            ,null          
            ,null        
            ,null         
            ,:new.value_date          
            ,:new.amount   
            ,:new.is_active           
            ,:new.is_planned          
            ,:new.document_id
            ,coalesce(gl.bd, glb_bankdate)
            ,glb_bankdate
            ,user_id()
            ,sysdate); 
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_REGISTER_HISTORY.sql ===*** End
PROMPT ===================================================================================== 
