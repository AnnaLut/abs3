

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Trigger/TI_OPER_NEWOPRNOM.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_OPER_NEWOPRNOM ***

  CREATE OR REPLACE TRIGGER FINMON.TI_OPER_NEWOPRNOM 
BEFORE INSERT
ON FINMON.OPER
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
begin
    :new.NEW_OPER_NOM := :new.OPR_NOM;
end;
/
ALTER TRIGGER FINMON.TI_OPER_NEWOPRNOM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Trigger/TI_OPER_NEWOPRNOM.sql =========***
PROMPT ===================================================================================== 
