

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TD_V_NBUR_I89_EDIT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TD_V_NBUR_I89_EDIT ***

  CREATE OR REPLACE TRIGGER BARS.TD_V_NBUR_I89_EDIT 
INSTEAD OF DELETE
ON BARS.V_NBUR_I89_EDIT
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
   lv_kodp_old varchar2(200);
BEGIN
   lv_kodp_old := :old.SEG_01 || :old.SEG_02 ;
        
   delete from tmp_irep
   where datf = :old.datf and
        kodf = '89' and
        kodp = lv_kodp_old;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END;
/
ALTER TRIGGER BARS.TD_V_NBUR_I89_EDIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TD_V_NBUR_I89_EDIT.sql =========*** 
PROMPT ===================================================================================== 