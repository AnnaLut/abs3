declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_family_fo
     (
            request_id number(38),
            rnk        number(38),
            status_f   varchar2(5),
            members    number(2),
            kf         varchar2(6 char)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception
    when name_already_used then
         null;
end;
/

comment on table core_family_fo is 'ѳ������ ���� �������� �� ������� ���, �� ����������� �� ���� ��������';
comment on column core_family_fo.rnk is '��������������� �����.';
comment on column core_family_fo.status_f  is 'ѳ������ ���� ��������';
comment on column core_family_fo.members is 'ʳ������ ���, �� ����������� ��  �������� ��������';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index ui_core_family_fo on core_family_fo (request_id, rnk) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/
