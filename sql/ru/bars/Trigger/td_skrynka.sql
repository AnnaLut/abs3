

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TD_SKRYNKA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TD_SKRYNKA ***

  CREATE OR REPLACE TRIGGER BARS.TD_SKRYNKA 
   after delete
   ON skrynka
   FOR EACH ROW
DECLARE
BEGIN
   insert into skrynka_arc(O_SK,N_SK,SNUM,KEYUSED,ISP_MO,KEYNUMBER,branch)
   values (:OLD.O_SK,:OLD.N_SK,:OLD.SNUM,:OLD.KEYUSED,:OLD.ISP_MO,:OLD.KEYNUMBER,:OLD.branch);
END;
/
ALTER TRIGGER BARS.TD_SKRYNKA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TD_SKRYNKA.sql =========*** End *** 
PROMPT ===================================================================================== 
