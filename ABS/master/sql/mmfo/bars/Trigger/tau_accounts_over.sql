CREATE OR REPLACE TRIGGER TAU_ACCOUNTS_OVER   AFTER UPDATE OF Ostc  ON ACCOUNTS   FOR EACH ROW
  WHEN  ( NEW.nbs IN ('2600', '2650', '2620','2602','2603','2604')   AND (NEW.Ostc < 0 OR OLD.Ostc < 0)   OR
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
