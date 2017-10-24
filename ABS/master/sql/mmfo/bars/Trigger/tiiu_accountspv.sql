

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIIU_ACCOUNTSPV.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIIU_ACCOUNTSPV ***

  CREATE OR REPLACE TRIGGER BARS.TIIU_ACCOUNTSPV 
instead of insert or update or delete on accountspv for each row
declare
  l_acc   number;
  l_parid number;
begin
  if inserting then
     insert into accountsp(acc, dat1, dat2, parid, val)
     values (:new.acc, :new.dat1, to_date('31012099','ddmmyyyy'), :new.parid, :new.val)
     returning acc, parid into l_acc, l_parid;
  elsif deleting then
     delete from accountsp where acc=:old.acc and dat1=:old.dat1 and parid=:old.parid
     returning acc, parid into l_acc, l_parid;
  elsif updating then
     update accountsp set val=:new.val, dat1=:new.dat1 where acc=:old.acc and parid=:old.parid and dat1=:old.dat1;
     l_acc := :new.acc; l_parid := :new.parid;
  end if;
  for c in ( select acc, dat1,
                    nvl(lead(dat1, 1) over (order by dat1), to_date('01012100','ddmmyyyy')) dat2
               from accountsp
              where acc = l_acc and parid = l_parid )
  loop
     update accountsp set dat2=c.dat2-1 where acc=l_acc and parid=l_parid and dat1=c.dat1;
  end loop;  
end;


/
ALTER TRIGGER BARS.TIIU_ACCOUNTSPV ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIIU_ACCOUNTSPV.sql =========*** End
PROMPT ===================================================================================== 
