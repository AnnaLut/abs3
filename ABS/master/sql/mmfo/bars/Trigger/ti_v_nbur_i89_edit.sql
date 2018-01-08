

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_V_NBUR_I89_EDIT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_V_NBUR_I89_EDIT ***

  CREATE OR REPLACE TRIGGER BARS.TI_V_NBUR_I89_EDIT 
INSTEAD OF INSERT
ON BARS.V_NBUR_I89_EDIT
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
    lv_kodp varchar2(200);
    lv_mfo  varchar2(20) := bc.current_mfo;
    lv_nbuc varchar2(200);
    lv_typ  number;
BEGIN
   P_Proc_Set_int ('89', 'C', lv_nbuc, lv_typ);
   
   lv_kodp := :new.SEG_01 || :new.SEG_02 ;
        
   insert into tmp_irep(KODP, DATF, KODF, ZNAP, NBUC, ERR_MSG, kf, FL_MOD)
   values (lv_kodp, :new.datf, '89', :new.ZNAP, lv_nbuc, null, lv_mfo, 1);

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TI_V_NBUR_I89_EDIT;
/
ALTER TRIGGER BARS.TI_V_NBUR_I89_EDIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_V_NBUR_I89_EDIT.sql =========*** 
PROMPT ===================================================================================== 
