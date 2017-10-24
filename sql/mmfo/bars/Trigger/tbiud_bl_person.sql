

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_PERSON.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_BL_PERSON ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_BL_PERSON 
BEFORE DELETE OR INSERT OR UPDATE
ON BARS.BL_PERSON
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
tmpVar NUMBER;

BEGIN
   tmpVar := 0;

  if inserting or updating then
   begin
    :NEW.INS_DATE := SYSDATE;
     if :NEW.USER_ID is null then
        :NEW.USER_ID:=gl.aUID;
     end if;
     if :NEW.PERSON_ID is null then
        select s_person_id.nextval into :NEW.PERSON_ID from dual;
     end if;


   EXCEPTION
      WHEN OTHERS THEN
      bars_error.raise_error('BL',1,SQLERRM);
  end;

  if :NEW.LNAME is null then
    bars_error.raise_nerror('BL','BL_PRFM_NULL',to_char(:NEW.INN));
  end if ;

  if :NEW.FNAME is null then
    bars_error.raise_nerror('BL','BL_PRIM_NULL',to_char(:NEW.INN));
  end if ;
  if :NEW.BDATE is null then
    bars_error.raise_nerror('BL','BL_BDATE_NULL',to_char(:NEW.INN));
  end if ;

  if :NEW.INN is not null and :NEW.BDATE is not null then
     if nvl(v_okpo10(:NEW.INN,:NEW.BDATE),'0')!= :NEW.INN then
      bars_error.raise_nerror('BL','BL_BAD_OKPO',:NEW.LNAME,:NEW.FNAME,:NEW.MNAME,:NEW.INN);
     end if;
  end if;


  end if;


END TBIUD_BL_PERSON;



/
ALTER TRIGGER BARS.TBIUD_BL_PERSON ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BL_PERSON.sql =========*** End
PROMPT ===================================================================================== 
