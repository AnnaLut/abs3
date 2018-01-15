PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/data/table/msp_file_content_type__data.sql ==========*** Run ***
PROMPT ===================================================================================== 

begin
  insert into msp_file_content_type (id, name)
  values (1, ' витанц≥€ 1');

  insert into msp_file_content_type (id, name)
  values (2, ' витанц≥€ 2');
exception 
  when dup_val_on_index then 
    null;
end;
/
commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/data/table/msp_file_content_type__data.sql ==========*** End ***
PROMPT ===================================================================================== 
