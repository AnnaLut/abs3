PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/data/table/mbm_nbs_acc_types.sql ==========*** Run ***
PROMPT ===================================================================================== 

begin
  insert into bars.mbm_nbs_acc_types (nbs, type_id)
  values ('2909', 'CURRENT');
exception 
  when dup_val_on_index then 
    null;
end;
/

commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/data/table/mbm_nbs_acc_types.sql ==========*** End ***
PROMPT ===================================================================================== 
