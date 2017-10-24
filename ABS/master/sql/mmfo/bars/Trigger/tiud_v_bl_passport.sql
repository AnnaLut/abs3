

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_V_BL_PASSPORT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_V_BL_PASSPORT ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_V_BL_PASSPORT 
INSTEAD OF INSERT OR UPDATE OR DELETE  ON BARS.V_BL_PASSPORT FOR EACH ROW
declare
NEW_ V_BL_PASSPORT%rowtype;
passport_ boolean;

BEGIN
passport_:=false;
if inserting or updating then
   NEW_.PERSON_ID:=:NEW.PERSON_ID;
   NEW_.PASSPORT_ID:=:NEW.PASSPORT_ID;
   NEW_.PASS_SER:=bl.validation_pass_ser(:NEW.PASS_SER);
   NEW_.PASS_NUM:=bl.validation_pass_num(:NEW.PASS_NUM);
   NEW_.PASS_DATE:=:NEW.PASS_DATE;
   NEW_.PASS_OFFICE:=:NEW.PASS_OFFICE;
   NEW_.PASS_REGION:=:NEW.PASS_REGION;
   NEW_.BASE_ID:=nvl(:NEW.BASE_ID,0);

 if NEW_.BASE_ID=0 then
    if NEW_.PASSPORT_ID is null then
     select s_PASSPORT_id.nextval into NEW_.PASSPORT_ID  from dual;
    end if;
 end if;

  begin
    Insert into BL_PASSPORT
       (PASSPORT_ID, PERSON_ID, PASS_SER, PASS_NUM, PASS_DATE,
    PASS_OFFICE, PASS_REGION,BASE_ID)
     Values
       (NEW_.PASSPORT_ID, NEW_.PERSON_ID, NEW_.PASS_SER, NEW_.PASS_NUM, NEW_.PASS_DATE,
         NEW_.PASS_OFFICE, NEW_.PASS_REGION,NEW_.BASE_ID);
   EXCEPTION
     WHEN others THEN
   if NEW_.BASE_ID=0 and :NEW.PASSPORT_ID is null and sqlcode=-1 then
      bars_error.raise_nerror('BL','BL_ERROR_SEQUENCE','PASSPORT_ID=',to_char(NEW_.PASSPORT_ID));
   end if;
   if sqlcode=-1 then

    update BL_PASSPORT
        set
        PERSON_ID=NEW_.PERSON_ID,
        PASS_SER=NEW_.PASS_SER,
        PASS_NUM=NEW_.PASS_NUM,
        PASS_DATE=NEW_.PASS_DATE,
        PASS_OFFICE=NEW_.PASS_OFFICE,
        PASS_REGION=NEW_.PASS_REGION
        where PASSPORT_ID=NEW_.PASSPORT_ID and BASE_ID=NEW_.BASE_ID
        and ( nvl(PERSON_ID,0)!=nvl(NEW_.PERSON_ID,0) or
              nvl(PASS_SER,'0')!=nvl(NEW_.PASS_SER,'0') or
              nvl(PASS_NUM,0)!=nvl(NEW_.PASS_NUM,0) or
              nvl(PASS_DATE,gl.bd)!=nvl(NEW_.PASS_DATE,gl.bd) or
              nvl(PASS_OFFICE,'0')!=nvl(NEW_.PASS_OFFICE,'0') or
              nvl(PASS_REGION,'0')!=nvl(NEW_.PASS_REGION,'0')
             );
   else
      raise;
   end if;
  end;
end if;


if deleting then
 delete from BL_PASSPORT where PASSPORT_id=nvl(:OLD.PASSPORT_ID,0) and base_id=nvl(:OLD.BASE_ID,0);
end if;

END;



/
ALTER TRIGGER BARS.TIUD_V_BL_PASSPORT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_V_BL_PASSPORT.sql =========*** 
PROMPT ===================================================================================== 
