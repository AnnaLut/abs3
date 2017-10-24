

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_SWJOURNAL_STMT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_SWJOURNAL_STMT ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_SWJOURNAL_STMT 
before insert or update on sw_journal
for each row
declare
l_mt   sw_stmt.mt%type;

begin

    begin
        select mt into l_mt from sw_stmt where mt = :new.mt;
    exception
        when NO_DATA_FOUND then return; -- Если не выписка, то ничего делать не нужно
    end;

    -- В случае входящей выписки и не подобранного корсчета, выбираем его
    if (:new.io_ind = 'O' and :new.accd is null) then

        begin
            select b.acc
              into :new.accd
              from bic_acc b, accounts a, tabval t
             where b.bic = :new.sender
               and b.acc = a.acc
               and a.kv  = t.kv
               and t.lcv = :new.currency
               and a.nbs = '1500';

        exception
            when NO_DATA_FOUND then null;
            when TOO_MANY_ROWS then null;
        end;

    end if;
    --если выписка по UAH добавляем в референс "+" согласно стандарту УкрСвифт
    if :new.currency='UAH' and instr(:new.trn,'+')=0 then
       :new.trn:=substr('+'||:new.trn,1,16);
       update sw_operw sw set sw.value=:new.trn
        where sw.swref=:new.swref
          and sw.tag='20';
    end if;
end;


/
ALTER TRIGGER BARS.TBIU_SWJOURNAL_STMT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_SWJOURNAL_STMT.sql =========***
PROMPT ===================================================================================== 
