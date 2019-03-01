declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_person_fo
     (
            request_id              number(38),
            rnk                     number(38),
            lastname                varchar2(100 char),
            firstname               varchar2(100 char),
            middlename              varchar2(100 char),
            isrez                   varchar2(5 char),
            inn                     varchar2(20 char),
            birthday                date,
            countrycodnerez         varchar2(3 char),
            k060                    varchar2(2 char),
            person_code             varchar2(30 char),
            default_person_kf       varchar2(6 char),
            default_person_id       number(38),
            person_object_id        number(38),
            status                  varchar2(30 char),
            status_message          varchar2(4000 byte),
            kf                      varchar2(6 char)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception
    when name_already_used then
         null;
end;
/

comment on table core_person_fo is '������� ��';
comment on column core_person_fo.rnk is '��������������� �����';
comment on column core_person_fo.lastname is '�������';
comment on column core_person_fo.firstname is '��''�';
comment on column core_person_fo.middlename is '�� �������';
comment on column core_person_fo.isrez is '������ �����';
comment on column core_person_fo.inn is '���������������� ���';
comment on column core_person_fo.birthday is '���� ����������';
comment on column core_person_fo.status is '������';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index ui_core_person_fo on core_person_fo (request_id, rnk) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index I_CORE_PERSON_FO_RNK on CORE_PERSON_FO (RNK) tablespace BRSMDLD';
exception
    when name_already_used then
         null;
end;
/

begin
	execute immediate'alter table core_person_fo add k020 VARCHAR2(20)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/

begin
	execute immediate'alter table core_person_fo add codDocum number(2)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/

begin
	execute immediate'alter table core_person_fo add isKr number(1)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/

begin
  execute immediate'alter table CORE_PERSON_FO add education number(1)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/

begin
  execute immediate'alter table CORE_PERSON_FO add typew number(1)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/

begin
	execute immediate'alter table CORE_PERSON_FO add codedrpou varchar(20)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/

begin
  execute immediate'alter table CORE_PERSON_FO add namew varchar(254)';
exception
 when others then if sqlcode=-955 then null; end if;
end;
/

