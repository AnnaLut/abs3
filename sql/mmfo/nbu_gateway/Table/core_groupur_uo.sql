declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_groupur_uo 
     (
            request_id   number(38),
            rnk          number(38),
            whois        number(1),
            isrezgr      varchar2(4000 byte),
            codedrpougr  varchar2(4000 byte),
            nameurgr     varchar2(4000 byte),
            countrycodgr varchar2(4000 byte),
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

comment on table core_groupur_uo is '������ ��������� ���, �� ������� �� ����� ��������� ���, �� ����������� �� ������� ���������';
comment on column core_groupur_uo.rnk is '��������������� �����.';
comment on column core_groupur_uo.whois is '������ ����� �������� ����� � ����';
comment on column core_groupur_uo.isrezgr is '������������ �����';
comment on column core_groupur_uo.codedrpougr is '��� ������';
comment on column core_groupur_uo.nameurgr is '������������ �����';
comment on column core_groupur_uo.countrycodgr is '��� ����� ���� ���������';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index i_core_groupur_uo on core_groupur_uo (request_id, rnk) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/
