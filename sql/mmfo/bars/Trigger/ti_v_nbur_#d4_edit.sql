

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_V_NBUR_#D4_EDIT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_V_NBUR_#D4_EDIT ***

  CREATE OR REPLACE TRIGGER BARS.TI_V_NBUR_#D4_EDIT 
INSTEAD OF INSERT
ON BARS.V_NBUR_#D4_EDIT
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
    lv_kodp varchar2(200);
    lv_mfo  varchar2(20) := bc.current_mfo;
BEGIN
   lv_kodp := :new.SEG_01 || :new.SEG_02 || :new.SEG_03 || :new.SEG_04;
        
   insert into tmp_nbu(KODP, DATF, KODF, ZNAP, NBUC, ERR_MSG, kf, FL_MOD)
   values (lv_kodp, :new.datf, 'D4', :new.ZNAP, lv_mfo, null, lv_mfo, 1);

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TI_V_NBUR_#D4_EDIT;
/
ALTER TRIGGER BARS.TI_V_NBUR_#D4_EDIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_V_NBUR_#D4_EDIT.sql =========*** 
PROMPT ===================================================================================== 
