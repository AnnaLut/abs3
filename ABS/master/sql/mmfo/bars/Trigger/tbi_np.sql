

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_NP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_NP ***

  CREATE OR REPLACE TRIGGER BARS.TBI_NP 
  BEFORE INSERT ON "BARS"."NP"
  REFERENCING FOR EACH ROW
  begin
select SQ_NP.nextval,decode(:NEW.ID,NULL,USER_ID,:NEW.ID)
       into :NEW.ID_NP,:NEW.ID from dual;
end;



/
ALTER TRIGGER BARS.TBI_NP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_NP.sql =========*** End *** ====
PROMPT ===================================================================================== 
