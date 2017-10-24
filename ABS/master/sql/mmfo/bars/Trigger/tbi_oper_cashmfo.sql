

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_CASHMFO.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_OPER_CASHMFO ***

  CREATE OR REPLACE TRIGGER BARS.TBI_OPER_CASHMFO 
  BEFORE INSERT ON BARS.OPER
  REFERENCING FOR EACH ROW
BEGIN
   IF length(:NEW.branch) = 8 and (substr(:NEW.NLSA,1,4) in ('1001','1002') or substr(:NEW.NLSB,1,4) in ('1001','1002')) THEN
       --raise_application_error(-20000, 'Заборонено проведення касових документів на рівні МФО ', true);
       bars_error.raise_nerror('DOC', 'CASH_MFO');
   END IF;
END;
/
ALTER TRIGGER BARS.TBI_OPER_CASHMFO DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_CASHMFO.sql =========*** En
PROMPT ===================================================================================== 
