

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ZAPRET_26MFO.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ZAPRET_26MFO ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ZAPRET_26MFO 
  BEFORE INSERT OR UPDATE OF TOBO ON BARS.ACCOUNTS
  FOR EACH ROW
 WHEN (
substr(new.nls,1,2)='26'
      ) DECLARE
    err          EXCEPTION;
    erm          VARCHAR2(100);
BEGIN

   IF length(:new.tobo) = 8 and :new.tip <> 'W4I' and (:new.tip <> 'W4A' and :new.nbs is null )THEN
      erm := 'Заборонено відкриття/модифікація рахунків 26-ої групи на рівень МФО!';
      RAISE err;
   END IF;

   if length(:new.tobo) <= 15 and :new.tip <> 'W4I' and :new.tip like 'W4%'  and (:new.tip <> 'W4A' and :new.nbs is null) then
      erm := 'Заборонено відкриття/модифікація карткових рахунків на рівень МФО або 2-й рівень!';
      raise err;
   end if;

EXCEPTION
   WHEN err THEN
     raise_application_error(-(20000),'\     ' || erm,TRUE);

END TIU_ZAPRET_26MFO;
/
ALTER TRIGGER BARS.TIU_ZAPRET_26MFO DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ZAPRET_26MFO.sql =========*** En
PROMPT ===================================================================================== 
