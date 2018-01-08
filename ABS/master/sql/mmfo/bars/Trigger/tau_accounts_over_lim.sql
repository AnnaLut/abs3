PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_OVER_LIM.sql =========*
PROMPT ===================================================================================== 

/*
PROMPT *** Create  trigger TAU_ACCOUNTS_OVER_LIM ***

  CREATE OR REPLACE TRIGGER BARS.TAU_ACCOUNTS_OVER_LIM AFTER UPDATE OF Ostb  ON ACCOUNTS   FOR EACH ROW
   WHEN (NEW.Ostb < OLD.Ostb  and     new.tip ='OVN' ) declare
    pragma autonomous_transaction;
    l_s number ;
BEGIN
    l_s := :NEW.Ostb  -  :OLD.Ostb ;
    logger.info ('LIM-1*'|| :NEW.Ostb || ' < '|| :OLD.Ostb ||'*' || l_s  );
    OVRN.DEB_LIM ( :NEW.ACC, l_s ) ;
    logger.info ('LIM-OK*');
END TAU_ACCOUNTS_OVER_LIM ;
/
ALTER TRIGGER BARS.TAU_ACCOUNTS_OVER_LIM ENABLE;
*/

declare
    trigger_doesnt_exist exception;
    pragma exception_init(trigger_doesnt_exist, -4080);
begin
    execute immediate 'drop trigger TAU_ACCOUNTS_OVER_LIM';
exception
    when trigger_doesnt_exist then
         null;
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_OVER_LIM.sql =========*
PROMPT ===================================================================================== 
