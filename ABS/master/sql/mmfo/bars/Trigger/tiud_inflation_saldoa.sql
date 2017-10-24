

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_INFLATION_SALDOA.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_INFLATION_SALDOA ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_INFLATION_SALDOA 
INSTEAD OF DELETE OR INSERT OR UPDATE
ON BARS.V_INFLATION_SALDOA
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
l_count NUMBER;
/******************************************************************************
   NAME:       TIUD_INFLATION_SALDOA
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        18.09.2014      NovikovOV       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     TIUD_INFLATION_SALDOA
      Sysdate:         18.09.2014
      Date and Time:   18.09.2014, 15:53:26, and 18.09.2014 15:53:26
      Username:        NovikovOV (set in TOAD Options, Proc Templates)
      Table Name:      V_INFLATION_SALDOA (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   l_count := 0;
   --RAISE_APPLICATION_ERROR (-20111,to_char(:NEW.ACC)||' - '|| :NEW.FDAT||' - '|| :NEW.DOS*100||' - '|| :NEW.KOS*100);
   if deleting then
      delete from tmp_inflation_saldoa where acc=:OLD.ACC and fdat=:OLD.FDAT;
   end if;

   if inserting or updating then

        select count(*) into l_count from saldoa where acc=:NEW.ACC and fdat=:NEW.FDAT and dos=:NEW.DOS*100 and kos=:NEW.KOS*100;
        if l_count=1 then
           delete from tmp_inflation_saldoa where acc=:OLD.ACC and fdat=:OLD.FDAT;
         else
               begin
                insert into  tmp_inflation_saldoa (ACC, FDAT, OSTF, DOS, KOS) values (:NEW.ACC,:NEW.FDAT, 0, :NEW.DOS*100, :NEW.KOS*100);
               exception when dup_val_on_index then
               update tmp_inflation_saldoa set OSTF=0, DOS=:NEW.DOS*100, KOS=:NEW.KOS*100 where acc=:NEW.ACC and fdat=:NEW.FDAT;
               end;
          end if;
     end if;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TIUD_INFLATION_SALDOA;


/
ALTER TRIGGER BARS.TIUD_INFLATION_SALDOA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_INFLATION_SALDOA.sql =========*
PROMPT ===================================================================================== 
