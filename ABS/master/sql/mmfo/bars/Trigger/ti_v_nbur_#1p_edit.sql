

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_V_NBUR_#1P_EDIT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_V_NBUR_#1P_EDIT ***

  CREATE OR REPLACE TRIGGER BARS.TI_V_NBUR_#1P_EDIT 
INSTEAD OF INSERT
ON BARS.V_NBUR_#1P_EDIT
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
lv_kodp varchar2(200);
BEGIN
   lv_kodp := :new.SEG_01 || :new.SEG_02 || :new.SEG_03 || :new.SEG_04 || 
        :new.SEG_05 ||:new.SEG_06 ||:new.SEG_07 ||:new.SEG_08 ||:new.SEG_09;
        
   insert into tmp_nbu(KODP, DATF, KODF, ZNAP, NBUC, ERR_MSG, kf, FL_MOD)
   values (lv_kodp, :new.datf, '1P', :new.ZNAP, '300465', null, '300465', 1);

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TI_V_NBUR_#1P_EDIT;
/
ALTER TRIGGER BARS.TI_V_NBUR_#1P_EDIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_V_NBUR_#1P_EDIT.sql =========*** 
PROMPT ===================================================================================== 
