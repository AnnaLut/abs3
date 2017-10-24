

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_PERSON_UPDATE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_BL_PERSON_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_BL_PERSON_UPDATE 
after  update or delete ON BARS.BL_PERSON for each row
declare
f BL_PERSON_UPDATE%rowtype;
BEGIN


f.PERSON_ID:=:OLD.PERSON_ID;
f.INN:=:OLD.INN;
f.LNAME:=:OLD.LNAME;
f.FNAME:=:OLD.FNAME;
f.MNAME:=:OLD.MNAME;
f.BDATE:=:OLD.BDATE;
f.INN_DATE:=:OLD.INN_DATE;
f.INS_DATE:=:OLD.INS_DATE;
f.USER_ID:=:OLD.USER_ID;
f.BASE_ID:=:OLD.BASE_ID;

     Insert into BL_PERSON_UPDATE Values f;
end;



/
ALTER TRIGGER BARS.TBIUD_BL_PERSON_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_PERSON_UPDATE.sql =========
PROMPT ===================================================================================== 
