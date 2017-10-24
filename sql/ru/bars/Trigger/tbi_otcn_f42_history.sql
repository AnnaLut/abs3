

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_OTCN_F42_HISTORY.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_OTCN_F42_HISTORY ***

  CREATE OR REPLACE TRIGGER BARS.TBI_OTCN_F42_HISTORY 
BEFORE INSERT ON OTCN_F42_HISTORY FOR EACH ROW
declare
  ern CONSTANT POSITIVE := 1;
  err EXCEPTION;
  erm VARCHAR2(80) := 'Контрагента з РНК ' || :new.rnk || ' не зареєстровано!';
  cnt_ number:=0;
BEGIN
   :NEW.ODAT := sysdate;
   :NEW.USERID := USER_ID;

   select count(*)
   into cnt_
   from customer
   where rnk=:new.rnk;

   if cnt_=0 then
      raise err;
   end if;

exception when err then
  raise_application_error(-(20000+ern),'\'||erm,TRUE);
END;
/
ALTER TRIGGER BARS.TBI_OTCN_F42_HISTORY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_OTCN_F42_HISTORY.sql =========**
PROMPT ===================================================================================== 
