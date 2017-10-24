

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_DPUNBS4CUST.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_DPUNBS4CUST ***

  CREATE OR REPLACE TRIGGER BARS.TIU_DPUNBS4CUST 
   BEFORE INSERT OR UPDATE
   ON BARS.DPU_NBS4CUST
   FOR EACH ROW
DECLARE
   l_tmp   VARCHAR2 (1);
BEGIN
   -- перевірка правильності заповнення параметра K013
   BEGIN
      SELECT K013
        INTO l_tmp
        FROM KL_K013
       WHERE K013 = :new.K013 AND D_CLOSE IS NULL;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         bars_error.raise_nerror ('DPU', 'INVALID_K013', :new.K013);
   END;

   -- перевірка правильності заповнення параметра S181
   IF :new.S181 = '0'
   THEN
      NULL;                    -- для поточних рахунків комбінованих договорів
   -- додати перевірку на належ. рах. до поточ.
   ELSE
      BEGIN
         SELECT s181
           INTO l_tmp
           FROM KL_S181
          WHERE S181 = :new.S181;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            bars_error.raise_nerror ('DPU', 'INVALID_S181', :new.S181);
      END;
   END IF;
END TIU_DPUNBS4CUST;


/
ALTER TRIGGER BARS.TIU_DPUNBS4CUST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_DPUNBS4CUST.sql =========*** End
PROMPT ===================================================================================== 
