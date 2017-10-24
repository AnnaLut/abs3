

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_PASSPORT_UPDATE.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_BL_PASSPORT_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_BL_PASSPORT_UPDATE 
after  update or delete ON BARS.BL_PASSPORT for each row
declare
f BL_PASSPORT_UPDATE%rowtype;
BEGIN

f.PASSPORT_ID:=:OLD.PASSPORT_ID;
f.PERSON_ID:=:OLD.PERSON_ID;
f.PASS_SER:=:OLD.PASS_SER;
f.PASS_NUM:=:OLD.PASS_NUM;
f.PASS_DATE:=:OLD.PASS_DATE;
f.PASS_OFFICE:=:OLD.PASS_OFFICE;
f.PASS_REGION:=:OLD.PASS_REGION;
f.INS_DATE:=:OLD.INS_DATE;
f.USER_ID:=:OLD.USER_ID;
f.BASE_ID:=:OLD.BASE_ID;

     Insert into BL_PASSPORT_UPDATE Values f;
end;
/
ALTER TRIGGER BARS.TBIUD_BL_PASSPORT_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_PASSPORT_UPDATE.sql =======
PROMPT ===================================================================================== 
