declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin 
    execute immediate
    'create table core_partners_uo
     (
            request_id   number(38),
            rnk          number(38),
            isrezpr      varchar2(5),
            codedrpoupr  varchar2(20),
            nameurpr     varchar2(254),
            countrycodpr varchar2(3),
            kf           varchar2(6 char)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception
    when name_already_used then
         null;
end;
/

comment on table core_partners_uo is '������ ��������� ���, �� �������� �� ����� ��������� �����������';
comment on column core_partners_uo.rnk is '��������������� �����.';
comment on column core_partners_uo.isrezpr is '������������ �����';
comment on column core_partners_uo.codedrpoupr is '��� ������';
comment on column core_partners_uo.nameurpr is '������������ �����';
comment on column core_partners_uo.countrycodpr is '��� ����� ���� ���������';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index i_core_partners_uo on core_partners_uo (request_id, rnk) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/
