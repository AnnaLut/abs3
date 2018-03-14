declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_document_fo
     (
            request_id number(38),
            rnk        number(38),
            typed      number(1),
            seriya     varchar2(20),
            nomerd     varchar2(20),
            dtd        date,
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

comment on table core_document_fo is '�������� �� ������� ����� ��';
comment on column core_document_fo.rnk is '��������������� �����.';
comment on column core_document_fo.typed is '��� ���������';
comment on column core_document_fo.seriya is '���� ���������';
comment on column core_document_fo.nomerd is '����� ���������';
comment on column core_document_fo.dtd is '���� ������ ���������';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index i_core_document_fo on core_document_fo (request_id, rnk) tablespace brsmdli local compress 2';
exception
    when name_already_used then
         null;
end;
/
