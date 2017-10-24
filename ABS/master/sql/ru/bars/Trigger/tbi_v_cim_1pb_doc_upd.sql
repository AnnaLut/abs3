

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_V_CIM_1PB_DOC_UPD.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_V_CIM_1PB_DOC_UPD ***

  CREATE OR REPLACE TRIGGER BARS.TBI_V_CIM_1PB_DOC_UPD 
   INSTEAD OF UPDATE
   ON BARS.V_CIM_1PB_DOC    FOR EACH ROW
DECLARE
   n1        NUMBER := 0;
   l_kod_n   VARCHAR2 (12);
BEGIN
   UPDATE cim_1pb_ru_doc
      SET md = TO_CHAR (:new.md)
    WHERE ref_ca = :new.ref_ca;

   SELECT COUNT (*), MAX (VALUE)
     INTO n1, l_kod_n
     FROM operw
    WHERE tag = 'KOD_N' AND REF = :new.ref_ca;

   IF    (l_kod_n IS NULL AND :new.kod_n_ca IS NOT NULL)
      OR l_kod_n <> :new.kod_n_ca
   THEN
      IF n1 = 0
      THEN
         INSERT INTO operw (REF,
                            tag,
                            VALUE,
                            kf)
              VALUES (:new.ref_ca,
                      'KOD_N',
                      :new.kod_n_ca,
                      f_ourmfo);
      ELSE
         UPDATE operw
            SET VALUE = :new.kod_n_ca
          WHERE tag = 'KOD_N' AND REF = :new.ref_ca;
      END IF;

      UPDATE cim_1pb_ru_doc
         SET changed = 2, md = NULL
       WHERE ref_ca = :new.ref_ca;
   ELSIF :new.md IS NOT NULL
   THEN
      UPDATE cim_1pb_ru_doc
         SET md = TO_CHAR (:new.md)
       WHERE ref_ca = :new.ref_ca;
   END IF;
END;
/
ALTER TRIGGER BARS.TBI_V_CIM_1PB_DOC_UPD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_V_CIM_1PB_DOC_UPD.sql =========*
PROMPT ===================================================================================== 
