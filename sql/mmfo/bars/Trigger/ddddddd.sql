

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/DDDDDDD.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger DDDDDDD ***

  CREATE OR REPLACE TRIGGER BARS.DDDDDDD 
BEFORE DELETE OR INSERT OR UPDATE
ON BARS.CIG_DOG_GENERAL
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
tmpVar NUMBER;
/******************************************************************************
   NAME:       ddddddd
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        28.09.2016      soshkoev       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     ddddddd
      Sysdate:         28.09.2016
      Date and Time:   28.09.2016, 10:59:20, and 28.09.2016 10:59:20
      Username:        soshkoev (set in TOAD Options, Proc Templates)
      Table Name:      CIG_DOG_GENERAL (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN


if :NEW.ND=160595501 and :NEW.contract_type=5 then 
raise_application_error (-20111,'aaaa');
end if;

END ddddddd;
/
ALTER TRIGGER BARS.DDDDDDD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/DDDDDDD.sql =========*** End *** ===
PROMPT ===================================================================================== 
