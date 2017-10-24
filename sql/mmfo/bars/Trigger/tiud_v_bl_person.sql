

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_V_BL_PERSON.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_V_BL_PERSON ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_V_BL_PERSON 
INSTEAD OF INSERT OR UPDATE or DELETE  ON BARS.V_BL_PERSON FOR EACH ROW
declare

NEW_ V_BL_PERSON%rowtype;
pers_ boolean;

BEGIN

pers_:=false;

 if inserting or updating then
   NEW_.PERSON_ID:=:NEW.PERSON_ID;
   NEW_.INN:=:NEW.INN;
   NEW_.LNAME:=upper(trim(:NEW.LNAME));
   NEW_.FNAME:=upper(trim(:NEW.FNAME));
   NEW_.MNAME:=upper(trim(:NEW.MNAME));
   NEW_.BDATE:=:NEW.BDATE;
   NEW_.INN_DATE:=:NEW.INN_DATE;
   NEW_.BASE_ID:=nvl(:NEW.BASE_ID,0);
--   NEW_.:=:NEW.;

  if NEW_.BASE_ID=0 then
     if NEW_.PERSON_ID is null then
       -- сначало попытаемя найти данного человека
       begin
        select person_id into NEW_.PERSON_ID from BL_PERSON where LNAME=NEW_.LNAME and
              FNAME=NEW_.FNAME and MNAME=NEW_.MNAME and bdate=NEW_.BDATE and inn=NEW_.INN and NEW_.base_id=0 and rownum=1;
        pers_:=true;
       EXCEPTION WHEN no_data_found THEN
       -- не нашли создаем нового
         select s_person_id.nextval into NEW_.PERSON_ID  from dual;
         pers_:=false;
       end;
     end if;
  else
    if NEW_.PERSON_ID is null then
       bars_error.raise_nerror('BL','BL_ERROR_OUT_PRIMARY_KEY','');
    end if;
  end if;

   -- мы еще не знаем есть ли эта строка в базе (тогда пытаемся вставлять)
  if pers_ =false then
   begin
     Insert into BL_PERSON
        (PERSON_ID, INN, LNAME, FNAME, MNAME,
         BDATE, INN_DATE,BASE_ID)
      Values
        (NEW_.PERSON_ID, NEW_.INN, NEW_.LNAME, NEW_.FNAME, NEW_.MNAME,
         NEW_.BDATE, NEW_.INN_DATE,NEW_.BASE_ID);
    EXCEPTION
      WHEN others THEN
     -- обратить внимание что именно :NEW.PERSON_ID
    if NEW_.BASE_ID=0 and :NEW.PERSON_ID is null and sqlcode=-1 then
       bars_error.raise_nerror('BL','BL_ERROR_SEQUENCE','PERSON_ID=',to_char(NEW_.PERSON_ID));
    end if;
    if sqlcode=-1 then
       pers_:=true;
    else
       raise;
    end if;



   end;
  end if;
  if pers_=true then
         update BL_PERSON
         set
         INN=NEW_.INN,
         LNAME=NEW_.LNAME,
         FNAME=NEW_.FNAME,
         MNAME=NEW_.MNAME,
         BDATE=NEW_.BDATE,
         INN_DATE=NEW_.INN_DATE
         where PERSON_ID=NEW_.PERSON_ID and BASE_ID=NEW_.BASE_ID
         and ( nvl(INN,0)!=nvl(NEW_.INN,0) or
               nvl(LNAME,'0')!=nvl(NEW_.LNAME,'0') or
               nvl(FNAME,'0')!=nvl(NEW_.FNAME,'0') or
               nvl(MNAME,'0')!=nvl(NEW_.MNAME,'0') or
               nvl(BDATE,gl.bd)!=nvl(NEW_.BDATE,gl.bd) or
               nvl(INN_DATE,gl.bd)!=nvl(NEW_.INN_DATE,gl.bd)
              );
  end if;



 end if;

 if deleting then
    delete from BL_PERSON where person_id=:OLD.PERSON_ID and base_id=nvl(:OLD.BASE_ID,0);
 end if;

END;



/
ALTER TRIGGER BARS.TIUD_V_BL_PERSON ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_V_BL_PERSON.sql =========*** En
PROMPT ===================================================================================== 
