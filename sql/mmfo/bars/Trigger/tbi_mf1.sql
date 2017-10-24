

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_MF1.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_MF1 ***

  CREATE OR REPLACE TRIGGER BARS.TBI_MF1 
  before insert  ON BARS.MF1 for each row
begin
     select s_mf1.nextval into :new.id  from dual;
end;



/
ALTER TRIGGER BARS.TBI_MF1 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_MF1.sql =========*** End *** ===
PROMPT ===================================================================================== 
