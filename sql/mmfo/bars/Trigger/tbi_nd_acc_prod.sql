

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ND_ACC_PROD.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ND_ACC_PROD ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ND_ACC_PROD 
BEFORE INSERT ON BARS.ND_ACC
FOR EACH ROW
DECLARE
  aa   accounts%rowtype;
  dd   cc_deal%rowtype;
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
    else

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
        -- вычитка из описания продукта
        select case aa.tip
                 when 'SS ' then OB22
                 when 'SPI' then SPI
                 when 'SDI' then SDI
                 when 'SN ' then SN
                 when 'SPN' then SPN
                 when 'SLN' then SLN
                 when 'CR9' then CR9
                 when 'SK0' then SK0
                 when 'SK9' then SK9
                 when 'SP ' then SP
                 when 'ISG' then ISG
                 when 'SG ' then SG
                 when 'S36' then S36
                 when 'S9N' then substr(S9N,1,2)
                 when 'SL ' then substr(SL, 1,2)
                 else null
               end
          into aa.OB22
          from BARS.CCK_OB22
         where NBS  = substr(dd.PROD,1,4)
           and OB22 = substr(dd.PROD,5,2);
      exception
        when NO_DATA_FOUND then
          aa.OB22 := null;
      end;

      if ( aa.BRANCH <> dd.BRANCH or aa.OB22 is Not Null )
      then
        update BARS.ACCOUNTS
           set TOBO = dd.BRANCH          -- бранч КД переносим на бранч счета
             , OB22 = nvl(aa.OB22,OB22 ) -- присвоение ОБ22
         where ACC  = :NEW.ACC;
      end if;

    end if;

  exception
    when no_data_found then RETURN;
  end;

end TBI_ND_ACC_PROD;
/
ALTER TRIGGER BARS.TBI_ND_ACC_PROD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ND_ACC_PROD.sql =========*** End
PROMPT ===================================================================================== 
