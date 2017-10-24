

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_V_BL_REASON.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_V_BL_REASON ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_V_BL_REASON 
INSTEAD OF INSERT OR UPDATE  ON BARS.V_BL_REASON FOR EACH ROW
declare

NEW_ V_BL_REASON%rowtype;
reason_ boolean;

BEGIN

reason_:=false;
if inserting or updating then

   if :NEW.PERSON_ID is null  then
      bars_error.raise_nerror('BL','BL_ERROR_PRIMARY_KEY','PERSON_ID=');
   end if;

   NEW_.PERSON_ID:=:NEW.PERSON_ID;
   NEW_.REASON_ID:=:NEW.REASON_ID;
   NEW_.REASON_GROUP:=:NEW.REASON_GROUP;
   NEW_.BASE:=upper(trim(:NEW.BASE));
   NEW_.INFO_SOURCE:=upper(trim(:NEW.INFO_SOURCE));
   NEW_.COMMENT_TEXT:=:NEW.COMMENT_TEXT;
   NEW_.BASE_ID:=nvl(:NEW.BASE_ID,0);



 if NEW_.BASE_ID=0 then

    if NEW_.REASON_ID is null then
     select s_REASON_id.nextval into NEW_.REASON_ID  from dual;
    end if;
 end if;
  begin
    Insert into BL_REASON
       (REASON_ID, PERSON_ID, REASON_GROUP, BASE, INFO_SOURCE,COMMENT_TEXT,BASE_ID)
     Values
       (NEW_.REASON_ID, NEW_.PERSON_ID, NEW_.REASON_GROUP, NEW_.BASE, NEW_.INFO_SOURCE,NEW_.COMMENT_TEXT,NEW_.BASE_ID);

   EXCEPTION
     WHEN others THEN

   if NEW_.BASE_ID=0 and NEW_.REASON_ID is null and sqlcode=-1 then
      bars_error.raise_nerror('BL','BL_ERROR_SEQUENCE','PERSON_ID=',to_char(NEW_.PERSON_ID));
   end if;

   if sqlcode=-1 then

    update BL_REASON
        set
        PERSON_ID=NEW_.PERSON_ID,
        REASON_GROUP=NEW_.REASON_GROUP,
        BASE=NEW_.BASE,
        INFO_SOURCE=NEW_.INFO_SOURCE,
        COMMENT_TEXT=NEW_.COMMENT_TEXT
        where REASON_ID=NEW_.REASON_ID and BASE_ID=NEW_.BASE_ID
        and ( nvl(PERSON_ID,0)!=nvl(NEW_.PERSON_ID,0) or
              nvl(REASON_GROUP,'0')!=nvl(NEW_.REASON_GROUP,'0') or
              nvl(BASE,0)!=nvl(NEW_.BASE,0) or
              nvl(INFO_SOURCE,gl.bd)!=nvl(NEW_.INFO_SOURCE,gl.bd) or
              nvl(COMMENT_TEXT,'0')!=nvl(NEW_.COMMENT_TEXT,'0')
             );
   else
      raise;
   end if;

  end;

end if;

if deleting then
 delete from BL_REASON where reason_id=:NEW.reason_id and base_id=nvl(:OLD.BASE_ID,0);
end if;

END;



/
ALTER TRIGGER BARS.TIUD_V_BL_REASON ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_V_BL_REASON.sql =========*** En
PROMPT ===================================================================================== 
