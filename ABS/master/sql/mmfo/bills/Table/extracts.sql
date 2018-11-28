prompt create table extracts
begin
    execute immediate '
        create table extracts
        (
            extract_number_id number,
            extract_date date,
            constraint xpk_extracts primary key(extract_number_id)
        )
        organization index';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
comment on table bills.extracts is '��������';
comment on column bills.extracts.extract_number_id is '����� ��������';
comment on column bills.extracts.extract_date is '���� ������������ �������� / �������� �� ����';

grant select on extracts to bars_access_defrole;