

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_BRANCH.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_BRANCH ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_BRANCH 
after insert or delete on branch
declare
  l_job    binary_integer; 
begin
  dbms_job.submit(l_job, 'dbms_mview.refresh(''BARS.MV_KF'');');
end taiud_branch; 
/
ALTER TRIGGER BARS.TAIUD_BRANCH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_BRANCH.sql =========*** End **
PROMPT ===================================================================================== 
