

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TUD_MBK_ADD_9100.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TUD_MBK_ADD_9100 ***

  CREATE OR REPLACE TRIGGER BARS.TUD_MBK_ADD_9100 
INSTEAD OF DELETE OR UPDATE
ON BARS.MBK_ADD_9100
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
l_count_row NUMBER;
l_acc number;

BEGIN
   --введен новый счет 9100
 if updating and :NEW.NLS_9100 is not null and :NEW.KV_9100 is not null then
    begin
     -- ищем асс счета
    select a.acc into l_acc from accounts a where kv=:NEW.KV_9100 and a.nls=:NEW.NLS_9100 and a.dazs is null and a.nbs='9100';
     -- добавл€ем
    insert into nd_acc (nd,acc) values (:NEW.ND,l_acc);
    -- удал€ем все счета 9100 по договору кроме только что сохраненного.
    delete from nd_acc where nd=:NEW.ND 
                and acc in (select a.acc from accounts a, nd_acc n where a.acc=n.acc and n.nd=:NEW.ND and a.nbs='9100' )
                and acc!=l_acc;
                  -- что то не то ввели ничего не делаем
    exception when no_data_found then  null;
                  -- введен тот же счет  ничего не делаем
                   when dup_val_on_index then null;
    end;
 end if;
 
 
    --удалили счет и нажали сохранить (удал€ем только его)
 if updating and :NEW.NLS_9100 is null  then
    begin
    delete from nd_acc where nd=:NEW.ND 
                and acc in ( select a.acc from accounts a where kv=:OLD.KV_9100 and a.nls=:OLD.NLS_9100 and a.nbs='9100');
    end;
 end if;
     -- удал€ем все счета 9100 по договору
 if deleting then
    delete from nd_acc where nd=:OLD.ND and acc in (select a.acc from accounts a, nd_acc n where a.acc=n.acc and n.nd=:OLD.ND and a.nbs='9100' ) ;
 end if;




-- ѕќ¬“ќ–я≈ћ ¬—≈ јЌјЋќ√»„Ќќ ƒЋя —„≈“ј ƒ»— ќЌ“ј
   --введен новый счет SDI
 if updating and :NEW.NLS_SDI is not null and :NEW.KV_SDI is not null then
    begin
     -- ищем асс счета
    select a.acc into l_acc from accounts a where kv=:NEW.KV_SDI and a.nls=:NEW.NLS_SDI and a.dazs is null and a.nbs in( '1616','1626','3666');
     -- добавл€ем
    insert into nd_acc (nd,acc) values (:NEW.ND,l_acc);
    -- удал€ем все счета 1626 по договору кроме только что сохраненного.
    delete from nd_acc where nd=:NEW.ND 
                and acc in (select a.acc from accounts a, nd_acc n where a.acc=n.acc and n.nd=:NEW.ND and a.nbs in( '1616','1626','3666') )
                and acc!=l_acc;
                  -- что то не то ввели ничего не делаем
    exception when no_data_found then  null;
                  -- введен тот же счет  ничего не делаем
                   when dup_val_on_index then null;
    end;
 end if;
 
 
    --удалили счет и нажали сохранить (удал€ем только его)
 if updating and :NEW.NLS_SDI is null  then
    begin
    delete from nd_acc where nd=:NEW.ND 
                and acc in ( select a.acc from accounts a where kv=:OLD.KV_SDI and a.nls=:OLD.NLS_SDI and a.nbs in( '1616','1626','3666'));
    end;
 end if;
     -- удал€ем все счета SDI по договору
 if deleting then
 delete from nd_acc where nd=:OLD.ND and acc in (select a.acc from accounts a, nd_acc n where a.acc=n.acc and n.nd=:OLD.ND and a.nbs in( '1616','1626','3666') ) ;
 end if;
 

END TUD_MBK_ADD_9100;


/
ALTER TRIGGER BARS.TUD_MBK_ADD_9100 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TUD_MBK_ADD_9100.sql =========*** En
PROMPT ===================================================================================== 
