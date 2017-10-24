

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_LOST_PASS_UPDATE.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_BL_LOST_PASS_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_BL_LOST_PASS_UPDATE 
after  update or delete ON BARS.BL_LOST_PASS
for each row
DECLARE
F BL_LOST_PASS_UPDATE%rowtype;
BEGIN

f.PASS_SER:=:OLD.PASS_SER;
f.PASS_NUM:=:OLD.PASS_NUM;
f.LNAME:=:OLD.LNAME;
f.FNAME:=:OLD.FNAME;
f.MNAME:=:OLD.MNAME;
f.BDATE:=:OLD.BDATE;
f.BASE:= :OLD.BASE ;
f.INFO_SOURCE:=:OLD.INFO_SOURCE;
f.PASS_DATE:=  :OLD.PASS_DATE;
f.PASS_OFFICE:=:OLD.PASS_OFFICE;
f.INS_DATE:=   :OLD.INS_DATE;
f.USER_ID:=    :OLD.USER_ID ;
f.pass_new_id:=null;
f.BASE_ID:=:OLD.BASE_ID;

 if updating then
    if :NEW.PASS_SER||to_char(:NEW.PASS_NUM)!=:OLD.PASS_SER||to_char(:OLD.PASS_NUM)then
       f.pass_new_id:=:NEW.PASS_SER||to_char(:NEW.PASS_NUM);
    end if;
 end if;


--      Insert into BL_LOST_PASS_UPDATE (PASS_SER, PASS_NUM, LNAME, FNAME, MNAME,BDATE, BASE,
--                                       INFO_SOURCE, PASS_DATE,PASS_OFFICE,INS_DATE, USER_ID)
--                               Values (:OLD.PASS_SER, :OLD.PASS_NUM, :OLD.LNAME, :OLD.FNAME, :OLD.MNAME,:OLD.BDATE, :OLD.BASE,
--                                       :OLD.INFO_SOURCE, :OLD.PASS_DATE,:OLD.PASS_OFFICE,:OLD.INS_DATE, :OLD.USER_ID);
--
Insert into BL_LOST_PASS_UPDATE  values f;
END;
/
ALTER TRIGGER BARS.TBIUD_BL_LOST_PASS_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_LOST_PASS_UPDATE.sql ======
PROMPT ===================================================================================== 
