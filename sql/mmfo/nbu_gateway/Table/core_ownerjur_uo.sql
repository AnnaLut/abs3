declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_ownerjur_uo
     (
            request_id       number(38),
            rnk              number(38),
            rnkb             number(38),
            nameoj           varchar2(254),
            isrezoj          varchar2(5),
            codedrpouoj      varchar2(20),
            registrydayoj    date,
            numberregistryoj varchar2(32),
            countrycodoj     varchar2(3),
            percentoj        number(9,6),
            kf               varchar2(6 char)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception
    when name_already_used then
         null;
end;
/

comment on table core_ownerjur_uo is '�������� ������� ����� � ������� �����.';
comment on column core_ownerjur_uo.rnk is '��������������� �����.';
comment on column core_ownerjur_uo.rnkb is '���.����� ���������� �������';
comment on column core_ownerjur_uo.nameoj is '������������ �����';
comment on column core_ownerjur_uo.isrezoj is '������������ �����';
comment on column core_ownerjur_uo.codedrpouoj is '��� ������';
comment on column core_ownerjur_uo.registrydayoj is '���� �������� ���������';
comment on column core_ownerjur_uo.numberregistryoj is '����� �������� ���������';
comment on column core_ownerjur_uo.countrycodoj is '��� �����';
comment on column core_ownerjur_uo.percentoj is '������ �������� ������� �����';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index i_core_ownerjur_uo on core_ownerjur_uo (request_id, rnk) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/
