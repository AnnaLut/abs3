

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_V_M080.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_V_M080 ***

  CREATE OR REPLACE TRIGGER BARS.TU_V_M080 
  INSTEAD OF UPDATE OR INSERT OR DELETE
ON BARS.V_M080 REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
 If updating and :NEW.otm=1 then

    update TMP_CCK_REP set dk = 1 where nd = to_char(:OLD.ND );

    for k in (select n.acc from nd_acc n, accounts a
               where n.ND  = :OLD.ND              and n.acc = a.acc
                 and a.tip in ('SS ','SP ','SL ','CR9' )
                 and a.dazs is null )
    loop
       update specparam set s080=:NEW.M080 where acc=k.ACC;
       if SQL%rowcount = 0 then
          insert into specparam (acc,s080) values (k.acc,:NEW.M080);
       end if;
    end loop;
 end if;
END tu_V_M080 ;
/
ALTER TRIGGER BARS.TU_V_M080 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_V_M080.sql =========*** End *** =
PROMPT ===================================================================================== 
