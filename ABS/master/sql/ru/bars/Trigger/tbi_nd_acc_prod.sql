

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ND_ACC_PROD.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ND_ACC_PROD ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ND_ACC_PROD BEFORE INSERT ON BARS.ND_ACC
 REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
DECLARE
   aa accounts%rowtype;
   dd cc_deal%rowtype ;
   -- 04/05/2016 LitvinSO COBUSUPABS-4479 Не меняем бранч для 2625 при привязке
   -- 08.01.2014 DAV ограничил в запрсе длину кода продукта для докредитки
   --09.08.2013 Sta Ужесточение условий для применения триггера
begin

 begin
    select * into aa from accounts where acc = :NEW.ACC  ;
    select * into dd from cc_deal  where nd  = :new.ND   ;
    -- Не трогаем счета др.клиентов, безмодульные (ОБД) и депозиты ,

    -- Не делаем это для дрюдоговоров, кроме кредитов
    If dd.RNK <> aa.RNK OR aa.tip in ('ODB','DEP')  OR  dd.vidd NOT in (1,2,3,11,12,13) then
       RETURN ;
    end if   ;
    --------------------------------------------
    --бранч КД переносим на бранч счета
    If aa.tip not in ('ODB','DEP') and
       aa.nbs <> '2625' and
       dd.vidd in (1,2,3,11,12,13) and
       aa.BRANCH <> dd.BRANCH        then
       update accounts set tobo = dd.BRANCH where acc=:NEW.acc;
    end if;
 exception when no_data_found then RETURN;
 end;

 -- присвоение об22
 begin
    --вычитка из описания продукта
    select decode(aa.tip,'SS ',OB22,
                         'SPI',SPI,
                         'SDI',SDI,
                         'SN ',SN ,
                         'SPN',SPN,
                         'SLN',SLN,
                         'CR9',CR9,
                         'SK0',SK0,
                         'SK9',SK9,
                         'SP ',SP ,
                         'ISG',ISG,
                         'SG ',SG,
                         'S36',S36,
                         'S9N',substr(S9N,1,2),
                         'SL ',substr(SL, 1,2),
                               null)
    into aa.OB22
    from CCK_OB22 where NBS||OB22 = substr(dd.PROD,1,6) ;
 exception when no_data_found then RETURN;
 end;

 ----------------
 If aa.OB22 is not null then
    update specparam_int s
       set s.ob22 = (case when s.ob22 is null or s.ob22='00' or s.ob22='0' then aa.OB22 else s.ob22 end)
     where s.acc  = :new.ACC;

    if SQL%rowcount = 0 then
       insert into specparam_int (acc,ob22) values (:new.ACC,aa.OB22);
    end if;
 end if;

end tbi_ND_ACC_PROD;
/
ALTER TRIGGER BARS.TBI_ND_ACC_PROD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ND_ACC_PROD.sql =========*** End
PROMPT ===================================================================================== 
