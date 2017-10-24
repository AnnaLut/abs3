

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPTVIDDSTAFF_BRANCH.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPTVIDDSTAFF_BRANCH ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPTVIDDSTAFF_BRANCH 
before insert on dpt_vidd_staff
for each row
begin

    select branch into :new.branch
      from staff$base
     where id = :new.userid;

end tbi_dptviddstaff_branch;
/
ALTER TRIGGER BARS.TBI_DPTVIDDSTAFF_BRANCH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPTVIDDSTAFF_BRANCH.sql ========
PROMPT ===================================================================================== 
