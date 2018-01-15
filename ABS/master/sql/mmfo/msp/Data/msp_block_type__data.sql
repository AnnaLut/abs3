PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/data/table/msp_block_type__data.sql ==========*** Run ***
PROMPT ===================================================================================== 

begin
  insert into msp_block_type (id, name)
  values (5, 'За письмовою вимогою органів УПСЗН');
exception 
  when dup_val_on_index then 
    null;
end;
/

commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/data/table/msp_block_type__data.sql ==========*** End ***
PROMPT ===================================================================================== 
