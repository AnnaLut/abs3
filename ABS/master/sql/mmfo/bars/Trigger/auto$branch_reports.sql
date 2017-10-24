

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/AUTO$BRANCH_REPORTS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger AUTO$BRANCH_REPORTS ***

  CREATE OR REPLACE TRIGGER BARS.AUTO$BRANCH_REPORTS 
before insert or update of branch on BARS.REPORTS for each row      WHEN (new.branch is null) begin
  :new.branch := sys_context('bars_context','user_branch');
end;





/
ALTER TRIGGER BARS.AUTO$BRANCH_REPORTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/AUTO$BRANCH_REPORTS.sql =========***
PROMPT ===================================================================================== 
