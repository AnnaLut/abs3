

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_STAFF_BRANCH.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_STAFF_BRANCH ***

  CREATE OR REPLACE TRIGGER BARS.TAU_STAFF_BRANCH 
                        before update of branch, current_branch ON BARS.STAFF$BASE
                        for each row
                        begin
                          :new.current_branch:=null;
                        end tau_staff_branch;


/
ALTER TRIGGER BARS.TAU_STAFF_BRANCH DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_STAFF_BRANCH.sql =========*** En
PROMPT ===================================================================================== 
