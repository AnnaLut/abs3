

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_V_S080_2.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_V_S080_2 ***

  CREATE OR REPLACE TRIGGER BARS.TU_V_S080_2 
  INSTEAD OF UPDATE OR INSERT OR DELETE
ON BARS.V_S080_2 REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
 If updating and :NEW.otm=1 then
    for k in (select n.acc from nd_acc n, accounts a
               where n.ND  = :OLD.ND              and n.acc = a.acc
                 and a.tip in
                     ('SS ','SP ','SL ','SN ','SPN','SK0','SK9','CR9','LIM')
                 and a.dazs is null )
    loop
       update specparam set s080=:NEW.R080 where acc=k.ACC;
       if SQL%rowcount = 0 then
          insert into specparam (acc,s080) values (k.acc,:NEW.R080);
       end if;
    end loop;
 end if;
END tu_V_S080_2 ;



/
ALTER TRIGGER BARS.TU_V_S080_2 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_V_S080_2.sql =========*** End ***
PROMPT ===================================================================================== 
