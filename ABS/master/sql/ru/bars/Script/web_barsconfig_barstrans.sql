begin
    begin
        insert into web_barsconfig(grouptype, key, csharptype, val, comm)
        values (1,
                'WebAPIBaseURL',
                null,
                'https://web-server-name:port/barsroot/api/',
                '������� URL ��� ��������� �� Web-API ��� �� � ������� Oracle');
    exception
        when dup_val_on_index then
             null;
    end;

    begin
        insert into web_barsconfig(grouptype, key, csharptype, val, comm)
        values (1,
                'WalletDir',
                null,
                '�������: file:/u01/oracle/ssl',
                '���� �� �������� ������ Oracle');
    exception
        when dup_val_on_index then
             null;
    end;

    begin
        insert into web_barsconfig(grouptype, key, csharptype, val, comm)
        values (1,
                'WalletPass',
                null,
                '�������: qwerty',
                '������ �� ����� ������ Oracle');
    exception
        when dup_val_on_index then
             null;
    end;

    commit;
end;
/
