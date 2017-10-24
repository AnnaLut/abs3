

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_REASON_UPDATE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_BL_REASON_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_BL_REASON_UPDATE 
after  update or delete ON BARS.BL_REASON for each row
declare
f BL_REASON_UPDATE%rowtype;
BEGIN

f.REASON_ID:=:OLD.REASON_ID;
f.PERSON_ID:=:OLD.PERSON_ID;
f.REASON_GROUP:=:OLD.REASON_GROUP;
f.BASE:=:OLD.BASE;
f.INFO_SOURCE:=:OLD.INFO_SOURCE;
f.COMMENT_TEXT:=:OLD.COMMENT_TEXT;
f.INS_DATE:=:OLD.INS_DATE;
f.USER_ID:=:OLD.USER_ID;
f.BASE_ID:=:OLD.BASE_ID;

     Insert into BL_REASON_UPDATE Values f;
end;



/
ALTER TRIGGER BARS.TBIUD_BL_REASON_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_REASON_UPDATE.sql =========
PROMPT ===================================================================================== 
