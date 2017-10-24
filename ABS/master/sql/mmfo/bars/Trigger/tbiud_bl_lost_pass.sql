

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_LOST_PASS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_BL_LOST_PASS ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_BL_LOST_PASS 
BEFORE DELETE OR INSERT OR UPDATE
ON BARS.BL_LOST_PASS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
tmpVar NUMBER;

BEGIN
   tmpVar := 0;

  if inserting or updating then
   :NEW.INS_DATE := SYSDATE;
   :NEW.USER_ID:=gl.aUID;

--    if :NEW.USER_ID is null then
--       :NEW.USER_ID:=gl.aUID;
--    end if;


     :NEW.PASS_SER:=trim(upper(:NEW.PASS_SER));

     :NEW.PASS_SER:=bl.validation_pass_ser(:NEW.PASS_SER);
     :NEW.PASS_NUM:=bl.validation_pass_num(:NEW.PASS_NUM);

     if :NEW.base_id=0 then
       if :NEW.BDATE is not null and (:NEW.BDATE>(gl.bd-365*16) or :NEW.BDATE<to_date('01011900','ddmmyyyy')) then
           bars_error.raise_nerror('BL','BL_BDATE_CHANGE');
       end if;

     end if;
  end if;


--   EXCEPTION
--     WHEN OTHERS THEN
--     if SQLCODE>-20000 then
--      null;
--     else
--     raise;
--     end if;

END TBIUD_BL_LOST_PASS;



/
ALTER TRIGGER BARS.TBIUD_BL_LOST_PASS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_LOST_PASS.sql =========*** 
PROMPT ===================================================================================== 
