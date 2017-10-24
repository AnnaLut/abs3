

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_CHECKBLK.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_CHECKBLK ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOUNTS_CHECKBLK 
before update of blkd on accounts
for each row
declare
  l_acc_blkid number;
  l_dpa_blk   number;
  l_nbs       varchar2(4);
  l_fnr       lines_f.fn_r%type;
  l_idpr      lines_f.id_pr%type;
  l_err       lines_f.err%type;
  l_dat       lines_f.dat%type;
  i           number;
begin

  -- "Рахунок не введено в дію"
  l_acc_blkid := nvl(to_number(getglobaloption('ACC_BLKID')),0);
  -- "Заблоковано до отримання повідомлення про реєстрацію рахунку в ДПА"
  l_dpa_blk   := nvl(to_number(getglobaloption('DPA_BLK')),0);

  -- Проверка на блокировку "Рахунок не введено в дію"
  --    (устанавливается автоматически при открытии счета для проверки параметров).
  --    Пока счет заблокирован, в ДПА информация не отсылается.
  --    Изменить код блокировки может пользователь, которому дан такой доступ.
  if l_acc_blkid > 0 then

     -- изменение блокировки
     if (:new.blkd <> :old.blkd) and
        (:new.blkd = l_acc_blkid or :old.blkd = l_acc_blkid) then

        -- проверка на пользователя
        -- если пользователю выдана функция, значит ему можно менять
        begin
           select 1 into i from v_mainmenu_list where id = user_id and upper(funcname) like 'FUNNSIEDITF%V_ACC_BLK_ACT%P_ACC_UNBLOCKACT%';
        exception when no_data_found then
           -- Запрещено блокировать/разблокировать счет кодом 'Не введен в действие'
           bars_error.raise_nerror('CAC', 'ACCOUNT_BLK_ACT_ERROR');
        end;

        -- если счет отправляется в ДПА, ставим код блокировки "Заблоковано до отримання повідомлення про реєстрацію рахунку в ДПА"
        if l_dpa_blk > 0 then
           if :old.blkd = l_acc_blkid and :new.blkd <> l_acc_blkid and nvl(:new.vid,0) > 0 then
              -- балансовые счета только из табл. dpa_nbs
              begin
                 select unique nbs into l_nbs from dpa_nbs where type in ('DPA','DPK','DPP') and nbs=:new.nbs;
                 :new.blkd := l_dpa_blk;
              exception when no_data_found then
                 null;
              end;
           end if;
        end if;

     end if;

  end if;

  -- Проверка на блокировку "Заблоковано до отримання повідомлення про реєстрацію рахунку в ДПА"
  --    (устанавливается автоматически при открытии счета).
  --    Блокировка снимается автоматически при получении сообщения из ДПА.
  --    При ручном разблокировании нужна проверка.
  -- код блокировки указан
  if l_dpa_blk > 0 then
     if :old.blkd >= l_dpa_blk and :new.blkd < l_dpa_blk and :new.vid <> 0 then
        -- счет ДПА?
        begin
           select 1 into i
             from dpa_nbs
            where type in ('DPA','DPK','DPP')
              and nbs = :new.nbs
              and taxotype in (1, 6)
              and rownum = 1;
           -- была отправка в ДПА?
           begin
              select fn_r, id_pr, err, dat
                into l_fnr, l_idpr, l_err, l_dat
                from lines_f f
               where nls = :new.nls
                 and kv  = :new.kv
                 and otype in (1, 6)
                 and dat = (select max(dat) from lines_f where nls=f.nls and kv=f.kv and otype=f.otype);
              if ( -- получена квитанция @R
                   (l_fnr like '@R%' or l_fnr like '@I%') and
                   -- 0-без помилок
                   -- 5-Рахунок вже перебуває на обліку
                   nvl(l_idpr,0) in (0, 5) and
                   --  0000-без помилок
                   nvl(l_err,'0000') = '0000' )
              or ( -- получена квитанция @F2
                   l_fnr like '@F2%' and
                   -- не пізніше наступного робочого дня при наявності квитанцій @F1 та @F2 забезпечити розблокування рахунку
                   trunc(l_dat) < bankdate )
              then
                 -- все нормально
                 null;
              else
                 -- Запрещено разблокировать счет до получения сообщения о регистации счета из ДПА
                 bars_error.raise_nerror('CAC', 'ACCOUNT_BLK_DPA_ERROR');
              end if;
           -- счет в ДПА не отправлялся (м.б. старый счет)
           exception when no_data_found then null;
           end;
        exception when no_data_found then null;
        end;
     end if;
  end if;

end;
/
ALTER TRIGGER BARS.TBU_ACCOUNTS_CHECKBLK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_CHECKBLK.sql =========*
PROMPT ===================================================================================== 
