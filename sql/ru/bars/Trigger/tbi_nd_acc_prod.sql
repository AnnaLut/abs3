CREATE OR REPLACE TRIGGER BARS.TBI_ND_ACC_PROD
BEFORE INSERT ON BARS.ND_ACC
FOR EACH ROW
DECLARE
   aa accounts%rowtype;
   dd cc_deal%rowtype ;
   -- 04/05/2016 LitvinSO COBUSUPABS-4479 Не меняем бранч для 2625 при привязке
   -- 08.01.2014 DAV ограничил в запрсе длину кода продукта для докредитки
   -- 09.08.2013 Sta Ужесточение условий для применения триггера
begin
  
  begin
    
    select * into aa from accounts where acc = :NEW.ACC;
    select * into dd from cc_deal  where nd  = :new.ND;
    
    If ( dd.RNK <> aa.RNK                or
         dd.VIDD NOT in (1,2,3,11,12,13) or
         aa.TIP in ('ODB','DEP')         or
         aa.NBS = '2625'
       )
    then -- Не трогаем счета др.клиентов, безмодульные (ОБД), депозиты и БПК
      null;
    else -- бранч КД переносим на бранч счета
      if ( aa.BRANCH <> dd.BRANCH )
      then
        update BARS.ACCOUNTS 
           set tobo = dd.BRANCH 
         where acc  = :NEW.acc;
      end if;
    end if;
    
  exception
    when no_data_found then RETURN;
  end;
  
  -- присвоение об22
  begin
        bars_audit.info('TBI_ND_ACC_PROD1 dd.prod = '||dd.prod||' aa.tip= '||aa.tip); 
         if newnbs.g_state= 1 then
            begin
                SELECT r020_new||ob_new
                  INTO dd.prod
                  FROM TRANSFER_2017
                 WHERE r020_old||ob_old = dd.prod and r020_old <> r020_new;
            EXCEPTION WHEN NO_DATA_FOUND THEN null;
            end;
         end if;
         
         bars_audit.info('TBI_ND_ACC_PROD2 dd.prod = '||dd.prod||' aa.tip= '||aa.tip); 
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
      from CCK_OB22
     where NBS||OB22 = substr(dd.PROD,1,6);
  exception
    when NO_DATA_FOUND then
      aa.OB22 := null;
  end;
  
  If aa.OB22 is not null 
  then
    update BARS.ACCOUNTS
       set ob22 = aa.OB22
     where acc  = :new.ACC;
  end if;
  
end TBI_ND_ACC_PROD;
/
