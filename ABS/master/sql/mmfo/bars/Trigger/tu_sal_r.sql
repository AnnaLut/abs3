

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_SAL_R.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_SAL_R ***

  CREATE OR REPLACE TRIGGER BARS.TU_SAL_R 
   BEFORE INSERT OR UPDATE
   ON accounts
   FOR EACH ROW
BEGIN
   -- Репликация: Если это обновление, то ничего не делаем
   IF (DBMS_MVIEW.i_am_a_refresh = TRUE)
   THEN
      RETURN;
   END IF;

   IF (DBMS_REPUTIL.from_remote = TRUE)
   THEN
      gl.bDate := :new.bdate;
   ELSE
      :new.bdate := gl.bDate;
   END IF;
END;



/
ALTER TRIGGER BARS.TU_SAL_R ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_SAL_R.sql =========*** End *** ==
PROMPT ===================================================================================== 
