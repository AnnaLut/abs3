

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_CP_KOD_RATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_CP_KOD_RATE ***

  CREATE OR REPLACE TRIGGER BARS.TU_CP_KOD_RATE 
  AFTER UPDATE OF IR ON "BARS"."CP_KOD"
  REFERENCING FOR EACH ROW
DECLARE
   STOBO VARCHAR2(12);
BEGIN
 FOR K IN (SELECT D.ACC, I.ID
           FROM CP_DEAL D, ACCOUNTS A, INT_ACCN I
           WHERE D.ID=:NEW.ID AND D.ACC=A.ACC AND D.ACCR IS NOT NULL
             AND I.ACC=A.ACC  AND I.ID=:NEW.TIP-1
             AND (A.OSTC <>0 OR A.OSTB<>0) )
 LOOP
   UPDATE INT_RATN SET IR=:NEW.IR
   WHERE ACC=K.ACC AND ID=K.ID AND BDAT=GL.BDATE;
   IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO INT_RATN(ACC,ID,BDAT,IR )
         VALUES ( K.ACC, K.ID, GL.BDATE, :NEW.IR);
   END IF;

 END LOOP;
END;
/
ALTER TRIGGER BARS.TU_CP_KOD_RATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_CP_KOD_RATE.sql =========*** End 
PROMPT ===================================================================================== 
