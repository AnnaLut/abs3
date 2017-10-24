

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_V_PEREKRB_FORMULA.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_V_PEREKRB_FORMULA ***

  CREATE OR REPLACE TRIGGER BARS.TU_V_PEREKRB_FORMULA 
   INSTEAD OF UPDATE
   ON BARS.V_PEREKRB_FORMULA    REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   IF NVL (:new.formula, '0') <> NVL (:old.formula, '0')
   THEN
      UPDATE perekr_b
         SET formula = NVL (:new.formula, 0)
       WHERE ids = :old.ids and kv=:old.kv;
   END IF;
END tu_v_perekrb_formula;



/
ALTER TRIGGER BARS.TU_V_PEREKRB_FORMULA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_V_PEREKRB_FORMULA.sql =========**
PROMPT ===================================================================================== 
