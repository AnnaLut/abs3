

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU2_BRANCH.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU2_BRANCH ***

  CREATE OR REPLACE TRIGGER BARS.TAIU2_BRANCH 
after insert or update of branch on branch for each row
declare
  l_childbranch dpt_file_subst.child_branch%type;
begin
  begin
    select child_branch
    into l_childbranch
    from dpt_file_subst
    where parent_branch = :new.branch;
  exception when no_data_found then
    insert into dpt_file_subst(parent_branch, child_branch)
    values (:new.branch,:new.branch);
  end;
end taiu_branch;




/
ALTER TRIGGER BARS.TAIU2_BRANCH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU2_BRANCH.sql =========*** End **
PROMPT ===================================================================================== 
