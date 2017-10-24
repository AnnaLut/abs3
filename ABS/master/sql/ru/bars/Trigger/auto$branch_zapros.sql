

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/AUTO$BRANCH_ZAPROS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger AUTO$BRANCH_ZAPROS ***

  CREATE OR REPLACE TRIGGER BARS.AUTO$BRANCH_ZAPROS 
before insert or update of branch on BARS.ZAPROS for each row  WHEN (new.branch is null) begin
  :new.branch := sys_context('bars_context','user_branch');
end;

/
ALTER TRIGGER BARS.AUTO$BRANCH_ZAPROS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/AUTO$BRANCH_ZAPROS.sql =========*** 
PROMPT ===================================================================================== 
