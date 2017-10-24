

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAD_ARCRRP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAD_ARCRRP ***

  CREATE OR REPLACE TRIGGER BARS.TAD_ARCRRP 
after delete on arc_rrp for each row
begin
  delete from arc_sign where rec=:old.rec;
end;
/
ALTER TRIGGER BARS.TAD_ARCRRP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAD_ARCRRP.sql =========*** End *** 
PROMPT ===================================================================================== 
