

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_DAOS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_DAOS ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOUNTS_DAOS 
   BEFORE UPDATE OF DAOS ON BARS.ACCOUNTS
FOR EACH ROW
declare
  l_fdat   date;
BEGIN

  /**
  -- 05-08-2014 NVV
  -- BRSMAIN-2826  Запретить изменять дату открыти счета на более позднюю, чем дата возникновения остатка на счете
  */

  IF (:OLD.daos is not null and  :OLD.daos != :NEW.daos )
  THEN

      select min(fdat)
 	    into l_fdat
      from saldoa
	 where fdat <=  :NEW.daos
	   and abs(dos) + abs(kos) > 0
	   and acc= :NEW.acc;


    If (:new.daos > nvl(l_fdat, :NEW.daos) )
    Then
      raise_application_error( -20444, ' Рах.' || :new.nls  || ' вал.'|| :new.kv ||
                                       ' Дата першого.руху '  || to_char(l_fdat,'dd.mm.yyyy') || ' >=' ||
                                       ' Датi відкриття '     || to_char(:NEW.daos,'dd.mm.yyyy') );
    End if;



  END IF;

END TBU_ACCOUNTS_DAOS ;
/
ALTER TRIGGER BARS.TBU_ACCOUNTS_DAOS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_DAOS.sql =========*** E
PROMPT ===================================================================================== 
