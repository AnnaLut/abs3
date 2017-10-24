

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_OPERLIST_AUDIT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_OPERLIST_AUDIT ***

  CREATE OR REPLACE TRIGGER BARS.TU_OPERLIST_AUDIT 
   BEFORE INSERT OR UPDATE OR DELETE
   ON operlist
   FOR EACH ROW
declare
   l_change_type  varchar2(1);
begin
   If inserting then
      l_change_type := 'I';
   End if;

   If updating then
      l_change_type := 'U';
   end if;

   insert into operlist_audit(rec_dare, id , funcname, name,  userid, change_type)
   values(sysdate, :new.codeoper, :new.funcname, :new.name, user_id, l_change_type );
end;
/
ALTER TRIGGER BARS.TU_OPERLIST_AUDIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_OPERLIST_AUDIT.sql =========*** E
PROMPT ===================================================================================== 
