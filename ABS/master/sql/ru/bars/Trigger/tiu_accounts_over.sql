

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOUNTS_OVER.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACCOUNTS_OVER ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACCOUNTS_OVER 
AFTER UPDATE OF Ostc
ON ACCOUNTS
FOR EACH ROW
DECLARE
/******************************************************************************
   NAME:
   PURPOSE:
   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        09/11/2004             1. Created this trigger.
   NOTES:
   Automatically available Auto Replace Keywords:
      Object Name:
      Sysdate:         09/11/2004
      Date and Time:   09/11/2004, 21:23:38, and 09/11/2004 21:23:38
      Username:         (set in TOAD Options, Proc Templates)
      Table Name:       (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
SUM_COMIS_ NUMBER;
BEGIN
  IF :NEW.nbs IN (2600,2650,2620) AND (:NEW.Ostc<0 OR :OLD.Ostc<0) THEN
     IF Gl.bdate=bars.Bankdate_G()   THEN
    BEGIN
       SELECT SUM INTO SUM_COMIS_ FROM ACC_OVER_COMIS WHERE acc=:NEW.acc AND FDAT=Gl.bdate;
       EXCEPTION WHEN NO_DATA_FOUND THEN SUM_COMIS_:=0;
    END;
    IF SUM_COMIS_>:NEW.Ostc OR SUM_COMIS_>:OLD.Ostc THEN
    BEGIN
        INSERT INTO BARS.ACC_OVER_COMIS(acc,SUM,FDAT) VALUES (:NEW.acc,least(:NEW.Ostc,:OLD.Ostc),Gl.bdate);
        EXCEPTION WHEN OTHERS THEN UPDATE BARS.ACC_OVER_COMIS SET SUM=:NEW.Ostc  WHERE acc=:NEW.acc AND FDAT=Gl.bdate;
    END;
  END IF;
  END IF;
  END IF;
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
     RAISE;
END ;
/
ALTER TRIGGER BARS.TIU_ACCOUNTS_OVER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOUNTS_OVER.sql =========*** E
PROMPT ===================================================================================== 
