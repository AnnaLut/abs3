
begin  EXECUTE IMMEDIATE ' drop TRIGGER BARS.TAI_ACCOUNTS_OPEN' ;
--  неправильное имя триггера
exception when others then   if SQLCODE = - 04080 then null;   else raise; end if; 
end;
/

begin  EXECUTE IMMEDIATE ' drop TRIGGER TIU_ACCOUNTS_OVER ' ;
--  неправильное имя триггера
exception when others then   if SQLCODE = - 04080 then null;   else raise; end if; -- ORA-04080: trigger 'TIU_ACCOUNTS_OVER' does not exist
end;
/


CREATE OR REPLACE TRIGGER TAU_ACCOUNTS_OVER   AFTER UPDATE OF Ostc  ON ACCOUNTS   FOR EACH ROW
  WHEN  ( NEW.nbs IN ('2600', '2650', '2620')   AND (NEW.Ostc < 0 OR OLD.Ostc < 0)   OR
          new.tip ='OVN' and NEW.Ostc < OLD.Ostc   
         )
/*

12.05.2016 Sta
Фиксирует максимальній деб.остаток для сч  2600, 2650, 2620 за 1 день
Можно Использовать для :
- Анализа
- ОВР одного дня
- . . . 
*/
BEGIN  UPDATE ACC_OVER_COMIS x SET x.SUM = least ( :OLD.Ostc,:NEW.Ostc,x.SUM )  WHERE x.acc = :NEW.acc AND x.FDAT = Gl.bdate   ;
    if SQL%rowcount = 0 then INSERT INTO ACC_OVER_COMIS(acc,SUM,FDAT) VALUES (:NEW.acc, LEAST(:NEW.Ostc,:OLD.Ostc), Gl.bdate ) ; end if;
END TAU_ACCOUNTS_OVER ;
/
------------------
CREATE OR REPLACE TRIGGER TAU_ACCOUNTS_OVER_LIM   AFTER UPDATE OF Ostb  ON ACCOUNTS   FOR EACH ROW
  WHEN  (NEW.Ostb < OLD.Ostb  and     new.tip ='OVN' )
  declare
    pragma autonomous_transaction; 
    l_s number ;
BEGIN 
    l_s := :NEW.Ostb  -  :OLD.Ostb ; 
    logger.info ('LIM-1*'|| :NEW.Ostb || ' < '|| :OLD.Ostb ||'*' || l_s  );
    OVRN.DEB_LIM ( :NEW.ACC, l_s ) ;  
    logger.info ('LIM-OK*');    
END TAU_ACCOUNTS_OVER_LIM ;
/



show err;
