

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_STO_DET.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_STO_DET ***

  CREATE OR REPLACE TRIGGER BARS.TBI_STO_DET 
BEFORE INSERT ON STO_DET FOR EACH ROW
 WHEN (
NEW.idd IS NULL
      ) BEGIN

 SELECT bars_sqnc.get_nextval('S_STO_DET')
   INTO :NEW.idd
   FROM dual;

 :NEW.FREQ := Nvl(:NEW.FREQ,2);
 :NEW.WEND := Nvl(:NEW.WEND,1);
END;
/
ALTER TRIGGER BARS.TBI_STO_DET ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_STO_DET.sql =========*** End ***
PROMPT ===================================================================================== 
