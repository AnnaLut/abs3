

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_SKRYNKA_ACC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_SKRYNKA_ACC ***

  CREATE OR REPLACE TRIGGER BARS.TIU_SKRYNKA_ACC 
   AFTER INSERT OR UPDATE
   ON BARS.SKRYNKA_ACC
DECLARE
   e_   NUMBER;
BEGIN
   SELECT COUNT (*)
     INTO e_
     FROM (SELECT   s.n_sk, a.nbs, COUNT (*)
               FROM skrynka_acc s, accounts a
              WHERE s.acc = a.acc
           GROUP BY s.n_sk, a.nbs
             HAVING COUNT (*) > 1);

   IF e_ > 0
   THEN
      raise_application_error
                 (- (20777),
                     '\'
                  || 'таблица SKRYNKA_ACC, не может двух одинаковых бс на сейф',
                  TRUE
                 );
   END IF;
END;
/
ALTER TRIGGER BARS.TIU_SKRYNKA_ACC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_SKRYNKA_ACC.sql =========*** End
PROMPT ===================================================================================== 
