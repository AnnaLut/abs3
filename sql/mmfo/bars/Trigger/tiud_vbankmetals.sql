

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_VBANKMETALS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_VBANKMETALS ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_VBANKMETALS 
instead of insert or update or delete ON BARS.V_BANK_METALS for each row
declare
    l_row   bank_metals$local%rowtype;
    mfo_    varchar(6);
begin
    --
    -- для редактирования представления V_BANK_METALS
    --
    if nvl(:new.kf,0) = 0
       then

         begin
            select to_char(f_ourmfo_g)
              into mfo_
              from dual;
         exception when no_data_found then mfo_ := :new.kf;
         end;

       else mfo_ := :new.kf;
    end if;

    if inserting or updating then
        if :new.nls_3800 is not null then
            begin
                select acc into l_row.acc_3800 from accounts where kf=:new.kf and nls=:new.nls_3800 and kv=:new.kv;
            exception when no_data_found then
                raise_application_error(-20000, 'Рахунок не знайдено: '||:new.nls_3800, true);
            end;
        else
            l_row.acc_3800 := null;
        end if;
        --
        l_row.kf        := mfo_;
        l_row.branch    := :new.branch;
        l_row.kod       := :new.kod;
        l_row.cena      := :new.cena;
        l_row.cena_k    := :new.cena_k;
        --
    end if;
    if inserting then
        insert into bank_metals$local values l_row;
    elsif updating then
        update bank_metals$local set
            cena     =  l_row.cena,
            cena_k   =  l_row.cena_k,
            acc_3800 =  l_row.acc_3800
        where branch=:old.branch and kod=:old.kod;
    elsif deleting then
        delete from bank_metals$local where branch=:old.branch and kod=:old.kod;
    end if;
end;



/
ALTER TRIGGER BARS.TIUD_VBANKMETALS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_VBANKMETALS.sql =========*** En
PROMPT ===================================================================================== 
