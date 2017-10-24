

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_REASON.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_BL_REASON ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_BL_REASON 
BEFORE DELETE OR INSERT OR UPDATE
ON BARS.BL_REASON
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
tmpVar NUMBER;

BEGIN
   tmpVar := 0;

  if inserting  or updating then
   :NEW.INS_DATE := SYSDATE;
    if :NEW.USER_ID is null then
       :NEW.USER_ID:=gl.aUID;
    end if;
    if :NEW.REASON_ID is null then
       select s_REASON_id.nextval into :NEW.REASON_ID from dual;
    end if;


  end if;

   EXCEPTION
     WHEN OTHERS THEN
   bars_error.raise_error('BL',1,SQLERRM);
END TBIUD_BL_REASON;



/
ALTER TRIGGER BARS.TBIUD_BL_REASON ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_REASON.sql =========*** End
PROMPT ===================================================================================== 
