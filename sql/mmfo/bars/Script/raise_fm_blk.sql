prompt ��������� ��� ���������� �� � 77 �� 98

prompt ��������� �����
alter table accounts modify constraint FK_ACCOUNTS_RANG disable;

alter table accounts modify constraint FK_ACCOUNTS_RANG2 disable;

prompt ��������� ����������
update rang
set rang = 98
where rang = 77;

prompt ��������� accounts
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
prompt �������� �����
alter table accounts modify constraint FK_ACCOUNTS_RANG enable novalidate;

alter table accounts modify constraint FK_ACCOUNTS_RANG2 enable novalidate;