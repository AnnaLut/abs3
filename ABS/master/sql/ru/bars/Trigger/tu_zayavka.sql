

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ZAYAVKA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ZAYAVKA ***

  CREATE OR REPLACE TRIGGER BARS.TU_ZAYAVKA 
   AFTER UPDATE
   ON zayavka
   FOR EACH ROW
    WHEN (    new.viza <> old.viza
         AND new.fnamekb IS NOT NULL
         AND new.identkb IS NOT NULL) DECLARE
   l_idback   zay_back.id%TYPE;
   l_reason   zay_back.reason%TYPE;
BEGIN
   IF :new.viza = -1
   THEN
      l_idback := :new.idback;

      SELECT reason
        INTO l_reason
        FROM zay_back
       WHERE id = l_idback;
   ELSE
      l_idback := 0;
      l_reason := NULL;
   END IF;

   INSERT INTO zay_baop (id,
                         tipkb,
                         kod,
                         textback,
                         identkb,
                         fnamekb)
        VALUES (s_zay_baop.NEXTVAL,
                :new.tipkb,
                l_idback,
                l_reason,
                :new.identkb,
                :new.fnamekb);
END;
/
ALTER TRIGGER BARS.TU_ZAYAVKA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ZAYAVKA.sql =========*** End *** 
PROMPT ===================================================================================== 
