

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAY_COMISS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ZAY_COMISS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ZAY_COMISS 
BEFORE INSERT ON BARS.ZAY_COMISS
FOR EACH ROW
DECLARE
  l_id NUMBER;
BEGIN
  IF :new.id IS NULL OR :new.id = 0 THEN
     l_id := bars_sqnc.get_nextval('s_zay_comiss');
     :new.id := l_id;
  END IF;
END;

/
ALTER TRIGGER BARS.TBI_ZAY_COMISS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAY_COMISS.sql =========*** End 
PROMPT ===================================================================================== 