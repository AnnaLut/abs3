begin
    begin
        insert into web_barsconfig(grouptype, key, csharptype, val, comm)
        values (1,
                'WebAPIBaseURL',
                null,
                'https://web-server-name:port/barsroot/api/',
                'Базовий URL для зверненнь до Web-API АБС РУ зі сторони Oracle');
    exception
        when dup_val_on_index then
             null;
    end;

    begin
        insert into web_barsconfig(grouptype, key, csharptype, val, comm)
        values (1,
                'WalletDir',
                null,
                'Приклад: file:/u01/oracle/ssl',
                'Шлях до каталогу валетів Oracle');
    exception
        when dup_val_on_index then
             null;
    end;

    begin
        insert into web_barsconfig(grouptype, key, csharptype, val, comm)
        values (1,
                'WalletPass',
                null,
                'Приклад: qwerty',
                'Пароль до файлу валетів Oracle');
    exception
        when dup_val_on_index then
             null;
    end;

    commit;
end;
/
