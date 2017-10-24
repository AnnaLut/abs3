

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_VBPKBRANCH.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_VBPKBRANCH ***

  CREATE OR REPLACE TRIGGER BARS.TU_VBPKBRANCH 
instead of update on v_bpk_branch for each row
begin
  insert into branch_parameters (branch, tag, val)
  values (:old.branch, 'BPK_BRANCH', :new.code);
exception when dup_val_on_index then
  update branch_parameters
     set val = :new.code
   where branch = :old.branch
     and tag = 'BPK_BRANCH';
end;
/
ALTER TRIGGER BARS.TU_VBPKBRANCH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_VBPKBRANCH.sql =========*** End *
PROMPT ===================================================================================== 
