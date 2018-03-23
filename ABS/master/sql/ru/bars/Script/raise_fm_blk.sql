prompt Обновляем код блокировки ФМ с 77 до 98

prompt Отключаем ключи
alter table accounts modify constraint FK_ACCOUNTS_RANG disable;

alter table accounts modify constraint FK_ACCOUNTS_RANG2 disable;

alter table accounts_update modify constraint FK_ACCOUNTSUPD_RANG disable;

alter table accounts_update modify constraint FK_ACCOUNTSUPD_RANG2 disable;


prompt Обновляем справочник
update rang
set rang = 98
where rang = 77;

prompt Обновляем accounts
begin
    for kf in (select kf from mv_kf)
        loop
            bc.go(kf.kf);
            for rec in (select acc, blkk, blkd from accounts where blkk = 77 or blkd = 77)
                loop
                    update accounts t
                    set t.blkd = case when blkd = 77 then 98 else blkd end,
                        t.blkk = case when blkk = 77 then 98 else blkk end
                    where acc = rec.acc;
                end loop;
        end loop;
	bc.home();
end;
/
prompt Включаем ключи
alter table accounts modify constraint FK_ACCOUNTS_RANG enable novalidate;

alter table accounts modify constraint FK_ACCOUNTS_RANG2 enable novalidate;

alter table accounts_update modify constraint FK_ACCOUNTSUPD_RANG enable novalidate;

alter table accounts_update modify constraint FK_ACCOUNTSUPD_RANG2 enable novalidate;