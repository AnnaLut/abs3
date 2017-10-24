

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TSU_RKO_UPD.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TSU_RKO_UPD ***

  CREATE OR REPLACE TRIGGER BARS.TSU_RKO_UPD 
INSTEAD OF INSERT OR UPDATE ON v_rko_upd
FOR EACH ROW
DECLARE
  TYPE          IntTyp IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
  acc           IntTyp;
BEGIN

  acc(0):=:OLD.acc0;
  acc(1):= NULL;
  acc(2):= NULL;
  acc(3):= NULL;

  FOR i IN 0..3 LOOP
     BEGIN
        SELECT acc INTO acc(i) FROM accounts
         WHERE nls = (CASE i WHEN 0 THEN :NEW.nls0
                             WHEN 1 THEN :NEW.nls1
                             WHEN 2 THEN :NEW.nls2
                             ELSE        :NEW.nlsD END)
           AND  kv = 980;
     EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
     END;
  END LOOP;

  IF INSERTING THEN
     INSERT INTO rko_lst (acc,acc1,acc2,accd) VALUES (acc(0),acc(1),acc(2),acc(3));
  ELSE
     UPDATE rko_lst SET acc1=acc(1) WHERE acc=acc(0);
     UPDATE rko_lst SET acc2=acc(2) WHERE acc=acc(0);
     UPDATE rko_lst SET accd=acc(3) WHERE acc=acc(0);
  END IF;

END;
/
ALTER TRIGGER BARS.TSU_RKO_UPD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TSU_RKO_UPD.sql =========*** End ***
PROMPT ===================================================================================== 
