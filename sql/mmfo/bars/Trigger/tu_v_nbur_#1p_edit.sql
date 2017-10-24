

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_V_NBUR_#1P_EDIT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_V_NBUR_#1P_EDIT ***

  CREATE OR REPLACE TRIGGER BARS.TU_V_NBUR_#1P_EDIT 
INSTEAD OF UPDATE
ON BARS.V_NBUR_#1P_EDIT
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
   lv_kodp_old varchar2(200);
   lv_kodp_new varchar2(200);
BEGIN
   lv_kodp_old := :old.SEG_01 || :old.SEG_02 || :old.SEG_03 || :old.SEG_04 || 
        :old.SEG_05 ||:old.SEG_06 ||:old.SEG_07 ||:old.SEG_08 ||:old.SEG_09;
        
   lv_kodp_new := :new.SEG_01 || :new.SEG_02 || :new.SEG_03 || :new.SEG_04 || 
        :new.SEG_05 ||:new.SEG_06 ||:new.SEG_07 ||:new.SEG_08 ||:new.SEG_09;
        
   update tmp_nbu
   set KODP = lv_kodp_new, 
       ZNAP = :new.znap,
       FL_MOD = 1
   where datf = :new.datf and
        kodf = '1P' and
        kodp = lv_kodp_old;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END;
/
ALTER TRIGGER BARS.TU_V_NBUR_#1P_EDIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_V_NBUR_#1P_EDIT.sql =========*** 
PROMPT ===================================================================================== 
