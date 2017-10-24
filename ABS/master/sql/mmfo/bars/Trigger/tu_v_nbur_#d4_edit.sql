

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_V_NBUR_#D4_EDIT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_V_NBUR_#D4_EDIT ***

  CREATE OR REPLACE TRIGGER BARS.TU_V_NBUR_#D4_EDIT 
INSTEAD OF UPDATE
ON BARS.V_NBUR_#D4_EDIT
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
   lv_kodp_old varchar2(200);
   lv_kodp_new varchar2(200);
BEGIN
   lv_kodp_old := :old.SEG_01 || :old.SEG_02 || :old.SEG_03 || :old.SEG_04;
        
   lv_kodp_new := :new.SEG_01 || :new.SEG_02 || :new.SEG_03 || :new.SEG_04;
        
   update tmp_nbu
   set KODP = lv_kodp_new, 
       ZNAP = :new.znap,
       FL_MOD = 1
   where datf = :new.datf and
        kodf = 'D4' and
        kodp = lv_kodp_old;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END;
/
ALTER TRIGGER BARS.TU_V_NBUR_#D4_EDIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_V_NBUR_#D4_EDIT.sql =========*** 
PROMPT ===================================================================================== 
