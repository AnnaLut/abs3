

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DOCBODY.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DOCBODY ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DOCBODY 
before insert ON DOC_BODY
FOR EACH ROW
BEGIN
    SELECT S_DOCBODY.NEXTVAL INTO :new.ID FROM dual;
end tbi_DOCBODY;
/
ALTER TRIGGER BARS.TBI_DOCBODY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DOCBODY.sql =========*** End ***
PROMPT ===================================================================================== 
