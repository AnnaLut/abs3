PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/data/table/msp_env_content_type__data.sql ==========*** Run ***
PROMPT ===================================================================================== 

begin
  insert into msp_env_content_type (id, name)
  values (1, ' витанц≥€ 1 - арх≥в');

  insert into msp_env_content_type (id, name)
  values (2, ' витанц≥€ 2 - арх≥в');
exception 
  when dup_val_on_index then 
    null;
end;
/
commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/data/table/msp_env_content_type__data.sql ==========*** End ***
PROMPT ===================================================================================== 
