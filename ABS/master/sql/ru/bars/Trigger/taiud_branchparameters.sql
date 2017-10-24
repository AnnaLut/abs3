

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_BRANCHPARAMETERS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_BRANCHPARAMETERS ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_BRANCHPARAMETERS 
after insert or update or delete on branch_parameters for each row
begin
  if ( inserting or updating ) and
     :new.tag in ('BPK_BOSS_FIO', 'BPK_BOSS_FIOR', 'BPK_DOVER', 'BPK_POSADA', 'BPK_POSADAR', 'BPK_PHONE') and
     length(:new.branch) > 8 then
     delete from cm_branch_params_values where branch = :new.branch and tag = :new.tag;
     insert into cm_branch_params_values (branch, tag, val) values (:new.branch, :new.tag, :new.val);
  elsif deleting and
     :old.tag in ('BPK_BOSS_FIO', 'BPK_BOSS_FIOR', 'BPK_DOVER', 'BPK_POSADA', 'BPK_POSADAR', 'BPK_PHONE') and
     length(:old.branch) > 8 then
     delete from cm_branch_params_values where branch = :old.branch and tag = :old.tag;
  end if;
end;
/
ALTER TRIGGER BARS.TAIUD_BRANCHPARAMETERS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_BRANCHPARAMETERS.sql =========
PROMPT ===================================================================================== 
