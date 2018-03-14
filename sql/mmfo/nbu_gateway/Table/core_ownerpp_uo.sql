declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_ownerpp_uo
     (
            request_id  number(38),
            rnk         number(38),
            rnkb        number(38),
            lastname    varchar2(100),
            firstname   varchar2(100),
            middlename  varchar2(100),
            isrez       varchar(5),
            inn         varchar2(20),
            countrycod  varchar2(3),
            percent     number(9,6),
            kf          varchar2(6 char)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception
    when name_already_used then
         null;
end;
/

comment on table core_ownerpp_uo is '�������� ������� ����� � ������� �����';
comment on column core_ownerpp_uo.rnk is '��������������� �����.';
comment on column core_ownerpp_uo.rnkb is '���.����� ���������� �������';
comment on column core_ownerpp_uo.lastname is '�������';
comment on column core_ownerpp_uo.firstname is '���';
comment on column core_ownerpp_uo.middlename is '�� �������';
comment on column core_ownerpp_uo.isrez is '������������ �����';
comment on column core_ownerpp_uo.inn is '�������������-��� ���';
comment on column core_ownerpp_uo.countrycod is '��� �����';
comment on column core_ownerpp_uo.percent is '������ �������� ������� �����';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index i_core_ownerpp_uo on core_ownerpp_uo (request_id, rnk) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/
