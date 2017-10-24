

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CCTRANS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CCTRANS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CCTRANS 
 before insert on CC_TRANS for each row
begin
  select S_CC_TRANS.nextval into :new.npp from dual;
end tbi_CCTRANS;
/
ALTER TRIGGER BARS.TBI_CCTRANS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CCTRANS.sql =========*** End ***
PROMPT ===================================================================================== 
