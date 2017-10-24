

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIIU_CUSTOMERPV.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIIU_CUSTOMERPV ***

  CREATE OR REPLACE TRIGGER BARS.TIIU_CUSTOMERPV 
instead of insert or update or delete on customerpv for each row
declare
  l_rnk   number;
  l_parid number;
begin
  if inserting then
     insert into customerp(rnk, dat1, dat2, parid, val)
     values (:new.rnk, :new.dat1, to_date('31012099','ddmmyyyy'), :new.parid, :new.val)
     returning rnk, parid into l_rnk, l_parid;
  elsif deleting then
     delete from customerp where rnk=:old.rnk and dat1=:old.dat1 and parid=:old.parid
     returning rnk, parid into l_rnk, l_parid;
  elsif updating then
     update customerp set val=:new.val, dat1=:new.dat1 where rnk=:old.rnk and parid=:old.parid and dat1=:old.dat1;
     l_rnk := :new.rnk; l_parid := :new.parid;
  end if;
  for c in ( select rnk, dat1,
                    nvl(lead(dat1, 1) over (order by dat1), to_date('01012100','ddmmyyyy')) dat2
               from customerp
              where rnk = l_rnk and parid = l_parid )
  loop
     update customerp set dat2=c.dat2-1 where rnk=l_rnk and parid=l_parid and dat1=c.dat1;
  end loop;  
end;


/
ALTER TRIGGER BARS.TIIU_CUSTOMERPV ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIIU_CUSTOMERPV.sql =========*** End
PROMPT ===================================================================================== 
