

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TR_CP_REZERV23.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TR_CP_REZERV23 ***

  CREATE OR REPLACE TRIGGER BARS.TR_CP_REZERV23 
 AFTER INSERT OR DELETE OR UPDATE ON "BARS"."CP_REZERV23"
  REFERENCING FOR EACH ROW
 declare l_type char(1);
 begin
  if inserting
  then l_type := 'I';
  elsif updating
  then l_type := 'U';
  elsif deleting
  then l_type := 'U';
  else l_type := '?';
  end if;

  if inserting or updating
  then
      begin
       insert into CP_REZERV23_UPDATE(ID, REF, DATE_REPORT, S_REZERV23, CHANGETYPE, USERID, CP_COUNT)
       values (:new.ID, :new.REF, :new.DATE_REPORT, :new.S_REZERV23, l_type, USER_ID, :new.CP_COUNT);
      end;
  elsif deleting
  then
      begin
       insert into CP_REZERV23_UPDATE(ID, REF, DATE_REPORT, S_REZERV23, CHANGETYPE, USERID, CP_COUNT)
       values (:old.ID, :old.REF, :old.DATE_REPORT, :old.S_REZERV23, l_type, USER_ID, :old.CP_COUNT);
      end;
  else return;
  end if;
end;
/
ALTER TRIGGER BARS.TR_CP_REZERV23 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TR_CP_REZERV23.sql =========*** End 
PROMPT ===================================================================================== 
