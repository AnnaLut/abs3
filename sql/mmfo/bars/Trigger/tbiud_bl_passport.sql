

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_PASSPORT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_BL_PASSPORT ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_BL_PASSPORT 
BEFORE DELETE OR INSERT OR UPDATE
ON BARS.BL_PASSPORT
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
tmpVar NUMBER;

BEGIN
   tmpVar := 0;

  if inserting or updating then
     :NEW.INS_DATE := SYSDATE;
     :NEW.USER_ID:=gl.aUID;

--    if :NEW.PASSPORT_ID is null then
--       select s_passport_id.nextval into :NEW.PASSPORT_ID from dual;
--    end if;

     :NEW.PASS_SER:=bl.validation_pass_ser(:NEW.PASS_SER);
     :NEW.PASS_NUM:=bl.validation_pass_num(:NEW.PASS_NUM);

  end if;


--   EXCEPTION
--     WHEN OTHERS THEN
--     if SQLCODE>-20000 then
--      null;
--     else
--     raise;
--     end if;
END TBIUD_BL_PASSPORT;



/
ALTER TRIGGER BARS.TBIUD_BL_PASSPORT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_PASSPORT.sql =========*** E
PROMPT ===================================================================================== 
