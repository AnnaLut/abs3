

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_CCK_RESTR_V.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_CCK_RESTR_V ***

  CREATE OR REPLACE TRIGGER BARS.TU_CCK_RESTR_V 
INSTEAD OF UPDATE
ON BARS.CCK_RESTR_V
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
 cnt_ NUMBER;
/******************************************************************************
   NAME:
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        11/08/2011             1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:
      Sysdate:         11/08/2011
      Date and Time:   11/08/2011, 11:30:54, and 11/08/2011 11:30:54
      Username:         (set in TOAD Options, Proc Templates)
      Table Name:      CCK_RESTR_V (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   if :OLD.ND <> :NEW.ND or
      :OLD.FDAT <> :NEW.FDAT or
      :OLD.VID_RESTR <> :NEW.VID_RESTR
   then
       select count(*)
       into cnt_
       from cck_restr
       where nd = :NEW.ND and
             fdat = :NEW.FDAT and
             vid_restr = :NEW.VID_RESTR;

       if cnt_ > 0 then
          raise_application_error(-20001, 'Такий запис вже існує!');
       end if;
   end if;

   update cck_restr
     set nd = :NEW.ND,
         fdat = :NEW.FDAT,
         vid_restr = :NEW.VID_RESTR,
         TXT = :NEW.TXT,
         SUMR = :NEW.SUMR,
         FDAT_END = :NEW.FDAT_END,
         PR_NO = :NEW.PR_NO
   where nd = :NEW.ND and
         fdat = :NEW.FDAT and
         vid_restr = :NEW.VID_RESTR;
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       raise;
END ;


/
ALTER TRIGGER BARS.TU_CCK_RESTR_V ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_CCK_RESTR_V.sql =========*** End 
PROMPT ===================================================================================== 
