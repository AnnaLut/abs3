

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_SKRYNKA_ND.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_SKRYNKA_ND ***

  CREATE OR REPLACE TRIGGER BARS.TIU_SKRYNKA_ND 
   AFTER INSERT OR UPDATE
   ON BARS.SKRYNKA_ND
DECLARE
   e_   NUMBER;
BEGIN
   SELECT COUNT (*)
     INTO e_
     FROM (
SELECT   s.n_sk, COUNT (*) c
    FROM skrynka_nd s
   WHERE sos = '0'
GROUP BY s.n_sk
  HAVING COUNT (*) > 1);

   IF e_ > 0
   THEN
      raise_application_error
         (- (20777),
             '\'
          || 'в таблице SKRYNKA_ND, не может быть два открытых договора на сейф (sos=0)',
          TRUE
         );
   END IF;
END;
/
ALTER TRIGGER BARS.TIU_SKRYNKA_ND ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_SKRYNKA_ND.sql =========*** End 
PROMPT ===================================================================================== 
