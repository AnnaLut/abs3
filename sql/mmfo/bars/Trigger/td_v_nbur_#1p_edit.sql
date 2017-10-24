

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TD_V_NBUR_#1P_EDIT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TD_V_NBUR_#1P_EDIT ***

  CREATE OR REPLACE TRIGGER BARS.TD_V_NBUR_#1P_EDIT 
INSTEAD OF DELETE
ON BARS.V_NBUR_#1P_EDIT
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
   lv_kodp_old varchar2(200);
BEGIN
   lv_kodp_old := :old.SEG_01 || :old.SEG_02 || :old.SEG_03 || :old.SEG_04 || 
        :old.SEG_05 ||:old.SEG_06 ||:old.SEG_07 ||:old.SEG_08 ||:old.SEG_09;
        
   delete from tmp_nbu
   where datf = :old.datf and
        kodf = '1P' and
        kodp = lv_kodp_old;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END;
/
ALTER TRIGGER BARS.TD_V_NBUR_#1P_EDIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TD_V_NBUR_#1P_EDIT.sql =========*** 
PROMPT ===================================================================================== 
