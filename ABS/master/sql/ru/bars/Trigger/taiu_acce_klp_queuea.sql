

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCE_KLP_QUEUEA.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_ACCE_KLP_QUEUEA ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_ACCE_KLP_QUEUEA 
after insert or update of pers, high on acce
for each row
declare
  sab_  customer.sab%type;
begin
  if (inserting and (:new.pers=1 or :new.high=1)) or
     (updating and ((:new.pers=1 and nvl(:old.pers,0)=0) or
                    (:new.high=1 and nvl(:old.high,0)=0))) then
    if (inserting and :new.pers=1) or
       (updating and :new.pers=1 and nvl(:old.pers,0)=0) then
      begin
        select sab
        into   sab_
        from   customer
        where  rnk in (select rnk
                       from   accounts
                       where  acc=:new.acc) and
               stmt=5                       and
               sab is not null;
        begin
          insert
          into   klp_QUEUEA (sab,
                             acc)
                     values (sab_,
                             :new.acc);
        exception when dup_val_on_index then
          null;
        end;
      exception when no_data_found then
        null;
      end;
    end if;
--
    if (inserting and :new.high=1) or
       (updating and :new.high=1 and nvl(:old.high,0)=0) then
      begin
        for k in (select c.sab
                  from   customer c,
                         klp_top  k
                  where  k.rnk in (select rnk
                                   from   accounts
                                   where  acc=:new.acc) and
                         c.rnk=k.rnkp                   and
                         c.stmt=5                       and
                         c.sab is not null
                 )
        loop
          begin
            insert
            into   klp_QUEUEA (sab,
                               acc)
                       values (k.sab,
                               :new.acc);
          exception when dup_val_on_index then
            null;
          end;
        end loop;
      end;
    end if;
  end if;
end taiu_acce_klpQUEUEA;
/
ALTER TRIGGER BARS.TAIU_ACCE_KLP_QUEUEA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCE_KLP_QUEUEA.sql =========**
PROMPT ===================================================================================== 
