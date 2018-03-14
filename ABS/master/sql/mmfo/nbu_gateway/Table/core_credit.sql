declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_credit
     (
            request_id      number(38),
            rnk             number(38),
            nd              number(30),
            ordernum        number(2),
            flagosoba       varchar2(5),
            typecredit      number(2), 
            numdog          varchar2(50),
            dogday          date,
            endday          date,
            sumzagal        number(32),
            r030            varchar2(3),
            proccredit      number(5,2),
            sumpay          number(32),
            periodbase      number(1),
            periodproc      number(1),
            sumarrears      number(32),
            arrearbase      number(32),
            arrearproc      number(32),
            daybase         number(5),
            dayproc         number(5),
            factendday      date,
            flagz           varchar2(5),
            klass           varchar2(2),
            risk            number(32),
            flaginsurance   varchar2(5),
            default_loan_kf varchar2(6 char),
            default_loan_id number(38),
            loan_object_id  number(38),
            status          varchar2(30),
            status_message  varchar2(4000 byte),
            kf              varchar2(6 char)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


comment on table core_credit is '������� ��������';
comment on column core_credit.rnk is '��������������� �����.';
comment on column core_credit.nd is '������ �����';
comment on column core_credit.ordernum is '���������� ����� �������� �������� � ���������';
comment on column core_credit.flagosoba is '������ �����';
comment on column core_credit.typecredit is '��� �������/�������� ����������� �����������';
comment on column core_credit.numdog is '����� ��������';
comment on column core_credit.dogday is '���� ��������� ��������';
comment on column core_credit.endday is 'ʳ����� ���� ��������� �������/�������� ����������� �����������';
comment on column core_credit.sumzagal is '�������� ���� (��� �������� ��/����������) �������� ����������� �����������';
comment on column core_credit.r030 is '��� ������';
comment on column core_credit.proccredit is '��������� ��������� ������';
comment on column core_credit.sumpay is '���� ������� �� ��������� ���������';
comment on column core_credit.periodbase is '����������� ������ ��������� �����';
comment on column core_credit.periodproc is '����������� ������ �������';
comment on column core_credit.sumarrears is '������� ������������� �� ��������� ���������';
comment on column core_credit.arrearbase is '����������� ������������� �� �������� ������';
comment on column core_credit.arrearproc is '����������� �������������  �� ����������';
comment on column core_credit.daybase is 'ʳ������ ��� ������������ �� �������� ������';
comment on column core_credit.dayproc is 'ʳ������ ��� ������������  �� ����������';
comment on column core_credit.factendday is '���� ���������� ��������� �������';
comment on column core_credit.flagz is '�������� ��������� ������ �� ����������� ��������� �����';
comment on column core_credit.klass is '���� ��������';
comment on column core_credit.risk is '�������� ���������� ������';
comment on column core_credit.flaginsurance is '���� �����������  �������';
comment on column core_credit.status is '������';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index i_core_credit on core_credit (request_id, nd) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/
